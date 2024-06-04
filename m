Return-Path: <linux-kernel+bounces-201539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C338FBFBD
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 01:16:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CD61F23A4E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 23:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAAB14D443;
	Tue,  4 Jun 2024 23:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="ErfJ97Iv"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2130.outbound.protection.outlook.com [40.107.243.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3301411F3;
	Tue,  4 Jun 2024 23:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717542956; cv=fail; b=acKuwgqp2FKBwGt1vxe9MUOmyrvWqqoGMffJWNog6fyNiKVrbkVOiq7iCzM8d/5dJh8UVlxIdwqhPJsOxqy+pZj6xpB7De+lvOSBlwoUpQyh5XE8u+/w6oWnjd4n2ea4db9sQtjsndMVol6/nIwiX3+SKIglRk5TnpEAygNqVJo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717542956; c=relaxed/simple;
	bh=8yhOX8tM1w63iYFI5z/tRhirG9lufe4J+HA+3yM1kPU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XquhseM+tBs2nsuhy/iwssXKS1F1CSX2wt3i5bTwYVM5WPwACHmHpwaNEDrGI3RbdUAgETbBais+lEQU+7BpdJgLo4WlgPZu4ql2h3HZ6ZmyUZq3zlmspwJ2aubrSFMa8SihQ1PJpIlUKL13dPa10wxwRwJUniwo6AZN7c/8nX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=ErfJ97Iv; arc=fail smtp.client-ip=40.107.243.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eugsEG+Tn3aNlnMJCNKxxKB3pCSP0E5Wm9oMryEcbCjMpxCekNNaJeid6NKnfI+EiKhwpED+4gcCCPEWIaYMP++bWoz1/c2+E0zdGimuItBsr2bT0IL9SrjUbMsyNrCkSO5RnrQ6LZEj9CqYw2rp+izcQfCEgHFEPub9aJjmBXNcYFeLlT9GN/4FADRy3yW5geB5M5tHXiZTgtKDqDog5H5xssyZF+5EbUAcAyXleSlkq9ihbqnP0efSY68fBa/p9WucQB2MSvAD4lMUNfJ7aGl77unFWc+WxVbF/vHqZDZCetcNNEZTM3LNB3V7tH9VxVjGZHrO4akB4O+ErB/cdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVVr54K2ora4V9Uc0NSU4MXre0h94S25NBqeXANeHGc=;
 b=Jt3qKuNGOXIGcfKbZw8soDMsOb+MzwKomYPvgx8kRAVYZH65F/JiYJU2wO2xwWWaum9Ok+oO+XpXCMKAJHPHMWX5dE1Y+jMkX2JumTGqOur16kzI4HW45ay7WRpnREgMDfkWhtNr5Y19eQPxoh0SfVgdTX6rIntzCQ0mjP+euvWYilgxnA7QxzXE4ItGHsfXOryeGD0zxFd0oN2pGB7Q+ok/IZay2MuC/wMeA8lBeiDEjmVAYhpWt1mekJzftA/SZCsvtaC6IfLqS17aCoTYuHInzEyDxtsZ2xBWavbF+km9227exNewVcPB7ccp7uEKrRA/jbXMQ+SMbZKgBCpjMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVVr54K2ora4V9Uc0NSU4MXre0h94S25NBqeXANeHGc=;
 b=ErfJ97IvxgG8XIicG9w6/oRVXdrSOoFgOtS6UFYFXHYx5+9+y0bdIy3GeuOC3w9lWi74ExLU1nCOUVQ4psTrPoRzXgZMzQHofs7Na7rpom9gfaWo298leurCIrvS/4cxjvnA2LlMjZUB1ISs+oQ76QskEDBSk2p8cphBAGC/Qmg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by SA6PR22MB5863.namprd22.prod.outlook.com (2603:10b6:806:418::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.25; Tue, 4 Jun
 2024 23:15:51 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::aaeb:2d53:9f16:db45%3]) with mapi id 15.20.7633.021; Tue, 4 Jun 2024
 23:15:51 +0000
Message-ID: <5a773641-73a6-416e-8c52-eccc136f11ef@phytec.com>
Date: Tue, 4 Jun 2024 16:15:48 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] Add overlays to disable optional hardware in
 k3-am6xx-phycore-som boards
To: Vignesh Raghavendra <vigneshr@ti.com>, nm@ti.com, kristo@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, upstream@lists.phytec.de, w.egorov@phytec.de
References: <20240528225137.3629698-1-nmorrisson@phytec.com>
 <4ac40139-eda0-4f6a-8bbe-99110605f91e@ti.com>
Content-Language: en-US
From: Nathan Morrisson <nmorrisson@phytec.com>
In-Reply-To: <4ac40139-eda0-4f6a-8bbe-99110605f91e@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0052.namprd04.prod.outlook.com
 (2603:10b6:303:6a::27) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|SA6PR22MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: da7b6f58-eff9-4588-b91e-08dc84ec4693
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eU0zb2lNVm9nWXBEanpRVkhva3duYTdSY0p6MmdwT3FlUDF5blNlVUFsU1p0?=
 =?utf-8?B?STV1WUU1ZERPWDRzd3diZmF0Q3E5SnJKbEl1dnpteTVKaHltcS92MGE2MDBt?=
 =?utf-8?B?MGhXVXBCcHNMU1ViODZGd0xEQmdGMVZnU2NnQ2RNMWEvajhhYXo5Y2R1d0dJ?=
 =?utf-8?B?cVI2N3lqOEVvVG1uRmVWWXdtZm9rSGFuSzh5eUdOTGlaVzkyNGFZWURPUE1y?=
 =?utf-8?B?YUlSTFprVStSTVA1ZGJPUjIxa281RmcxdW5FajNTc0l0K1VBa1dYRys5NDMr?=
 =?utf-8?B?cUNnemNlSlk0WGl5UnRlOE9WNnZQWXRwSlgxS0hwb1NHa2F6WkdacjNvNVJX?=
 =?utf-8?B?Z3dwSGx4Mmx1Q3MvMnRoL0J2aFlTWE9haDhtTkozWlJHdVd1a3JaQndzYzcw?=
 =?utf-8?B?dkpyaTdBKzUzZHV0OFNyN1VBRE1EUHByZnZCb29aR1o1SHkwQU9kSlFkZDRS?=
 =?utf-8?B?S3BYdlVGNkxNeWVZOUlQOW9vcUk3U0VmR0VRc0VHVXIvOWZoUkpMMnVhMnRz?=
 =?utf-8?B?bWx5clJTOGNQR2J5M210NUsyaktla2xmYUt1cG9KbG1JaEdMY3JJTnBCQ05k?=
 =?utf-8?B?bkptazNYdEVOS2dvTjJFSzdrRVVXWFhBZmpINFVXM1M0OE9zdnBLL0JITnla?=
 =?utf-8?B?eGNGTHlRYlZabmFBcmtNWDJkdUQrOWVIcndDVWZlRFJkdnk3RktUSUo2RFdl?=
 =?utf-8?B?NzNra05ZRUxTa2tiN3Y3MTR3SGczRy9oMUFoLzdqYnBCU1NiTWRYUmR5NlFu?=
 =?utf-8?B?MU13QmQ5TyttdENnWnJtRzlaS0lPQms3TzBUWDhGeVBwbm1PMnBZMjRiOUtt?=
 =?utf-8?B?dDVuUUdyZll0QlN2QTZLOEordVhXNkUxTm9EN2lhWGkrMFNBTkZJdStEYzd3?=
 =?utf-8?B?OXo2ZFdLN0lRUHRTbWtFSWFzbUU5QlpPeXdPY2ZjNlNReklvNHFmRThNeGxR?=
 =?utf-8?B?RmJ1VTRtVS8wSnp3UDZZdEU0UkpsT29qRXhQR3kvTXByVkFKSnlLK1VSekc1?=
 =?utf-8?B?Yi9pRHVIY2NjS0tvSk83NDhCU1FsWFVPa2IyeFRNZkVGQitoS3FRdzdFbGMz?=
 =?utf-8?B?L1p4V2kxTDNzN3FSbWJlRTVXUmgvVXBoS2tZZUZlTURMbTN1SWpFTy9XbHE0?=
 =?utf-8?B?SDlCbmNRWTl2S3NFdU1EaVA3NUhkRVA3aDE4aHYxVVZIZGN4blhNMmFHdXgv?=
 =?utf-8?B?OEpqVHlPcDU0aWxhV0x0d1BxazZOTnhYYkpmR3hOaEt5Y1J2MzFPcnRKOUZK?=
 =?utf-8?B?ZHlVZk1sY1A1MThxOEppdUhsczhxTExwbUtkdkRIQnFmdEpWbjRBSW9aYS9x?=
 =?utf-8?B?RTNxZTh2S3VldUlFZ1YzeE1nL2tFVkZJZmZtUmxCQ0pNTEJhT2VQRE00Y1h6?=
 =?utf-8?B?NmxsZWtreU90NHJ2OElRblVUOW5zeTBRekp1WFgzZ3VQQ0hQWndTTjFMVnYr?=
 =?utf-8?B?cFNwYUNPZVRyRGgyNDNMdFU2bHFXQ1EwYnEzOWxKdGFRWWNXQWM5K251U0RJ?=
 =?utf-8?B?ckQvclAzTVZuRlgrekdhVGNSZ3d3QTZHUVJuam9mc0VBLzJUa0dST3l1SWc0?=
 =?utf-8?B?TnpYWWZocGhzOTY4YkZHbTAwVFVxYjh4RVIzV0Nzb1k3NWZoWWYxU29XQmVi?=
 =?utf-8?B?cW1qSlZtK3l6RE9nMDNNUGp0WkFnOHA3UmtiK0RsWFM5clFUQXh5N0x3ektw?=
 =?utf-8?B?bmtOVlhuZTNOK0FudFRQbjVva25JdEZtc0RsYk1WMVZmYmNyZ3M2bWhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(7416005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z0JmckRqMy9kYlIyNEpKYjFCWXVPS2lSRWpmaHVTRlZLeWlhdnoxbmo2NzFK?=
 =?utf-8?B?Vjg1STV0ZlVncy85c0NKY29qR0F3VDNEMkxSRUdtd201ZklLVVBqTTlHUkhQ?=
 =?utf-8?B?MjVyam9aTC9BYnZoRGtoZnZXRUhhN28wVi9rZFlFM1pCdGhKUk9scUVESVRU?=
 =?utf-8?B?TEhkUkN2K2ZpdGNMZ24rYU1TVk5ONXJDanVJSTc5ODRhNnNQRWdGUWI2Q05X?=
 =?utf-8?B?a25JN2pYYjFBUU9vVHhkM1RkZWlOekJ5UVR2VW0xTGZ5N2NJWHBhaktJNTNz?=
 =?utf-8?B?MEw3MWpwa3JSaHdwa3U2cVFOM2NYRVlBTFBMbnJLVVlWWFF6MUNxWlE1cFB6?=
 =?utf-8?B?NzVIZXpNbnhwcUtndXVleVF0MlVsOXBxd0FoZHkyaXA3c20zRWtPUWJRS0dJ?=
 =?utf-8?B?TWM1UFVQaWJGSzRiUHVVYVlobG8vSHMxRHBMTDFNSHE5Y1hmcWJjVS9scG9x?=
 =?utf-8?B?RkpINlk4cU51YXRCblZvRi83K25aVTludUh5YVUzUXM5bXFzREgvbE5pdlIw?=
 =?utf-8?B?RklDVUJVQ3EyeEV6eW9MV3pZR21ub0pSbG5jeFc3MnhCcFlxRlpRUFVadlZE?=
 =?utf-8?B?SU5Ea09GRkxFVEdYZENxVXUya2JnOUVDYi8zRHhFQlF6bGcwek9kK2JmZ0Fp?=
 =?utf-8?B?YVBQZ2V5MU51N0xJN3M5TzJmV0xmeDB0a3YyRnhpanNpUUhaZFlaUWUrYTRI?=
 =?utf-8?B?allna3lZay94VG5USEdKSG9mQk5SSG05dTBCTzR3MlRqQXk5Qm8zeWhrVTVK?=
 =?utf-8?B?NlJBTzdRTWZXeHZxbXQ0L2I2V2p4RHB1bitYTExTK2ZSOXZ1RlZESUs2MTN6?=
 =?utf-8?B?ZzVzMjI0bjRDMUxnUmpleWtLTU44c0czazF6T2p2Yi9EMG9hWHE4ZE9uY2xj?=
 =?utf-8?B?VXRtOXBobWVWYTJaMS8vU2VpWmdsd0VkL3M4cG0zSHNJbXFzNCtXSFFkVm9n?=
 =?utf-8?B?bzhFVVhHY1NLOGFLQS95NFNScTZ3QVlZd01lSDBucmJNYmUrT0R2VDliSVlj?=
 =?utf-8?B?YnE5VnNpMFVzOHNIYUxFNEZOZy9scXE2MG9RSVZSY3FTL25MYzFnVFdCQ3pF?=
 =?utf-8?B?VlVnY1dTTlhhcFpGL0dsTVY4Z0lTRFoyaWEvUm5tZjAzNmRJak1YZWVaOEs2?=
 =?utf-8?B?N1ZJeWxLWFNzVEpwR1Q1dkttNlNPLzQ0dkhuR0psU1JSdGlqTExid0FPSlRF?=
 =?utf-8?B?TVRTZVlNM05IRDh6b2ZOMkh2aGcwQktvNmtTcWhLK1RmeUNwalNPbm9sWEFr?=
 =?utf-8?B?OWM0OHhuN2NtZnBjbjFvc2tGRXFDUms4RE9oTzhTSmlCK1J1V290ME9FK1pH?=
 =?utf-8?B?UWxMWVptajRZbUxsTW1rVWRRMU1MakRhVzFpb0taS0ZTRnVrc043UGkrOHJP?=
 =?utf-8?B?aGg1R1BqeGJNdDhVMDNRM3kwUVNxUXZISDlUMmp0SlZ6QjJHRE5McDVIWFE2?=
 =?utf-8?B?OXlSY3NVTW9ubUJnSUtjbHZHS1FXbHBrWVVlbkdmaS9DN2dTN1owVGxhRXB1?=
 =?utf-8?B?a2IzMC8zTksrdC9YcUJWSmNHLzBJUzVHT05rdzhidnNCbEZjNENvd1ZEWWl1?=
 =?utf-8?B?MXZyVTh3eW1heEI2Szd0czlEUzNuRk9KbHB6ekhHUFRLakpsWGtnRDY2RWlC?=
 =?utf-8?B?TjdoTENVUFZuVVg2MitTSXRMVllkZHVGeFJnN2hUSVUyZjNFaSs4TzViWUhi?=
 =?utf-8?B?TjhoS2J4SjhuVGxWVXh2N2FxcUtiZEUrL3lWZUJlUjJkWWZKOGsrZlFSTEFS?=
 =?utf-8?B?VTZyVjNMc29NbHVsT29Eb0RJby93TUhpMC8wRXdKdndGdG1NaTBlR1JrTUNQ?=
 =?utf-8?B?dG52eUdsNFZaMzBmaTBpdEpsb1JzMXVwS0JvOXFvY21BVzhMZXJNNHcvUGR6?=
 =?utf-8?B?akplalZhTlpKSEdKY094UlVVTnA0d29XVzRpSlF5am1OYTJMckMyOHl3ZHhs?=
 =?utf-8?B?TVViOVVzTkQ5U091WmhsSTVmUTlMR0FyZmhsSkRzNFBZdENDL2JtVVlsbm4x?=
 =?utf-8?B?NTI2OU9qeVNhNWJhNXdqYXFnN2dDWGRXcElOSnpqSmY2QjhDc0dpNmJQaktG?=
 =?utf-8?B?czliWTdYS3FWSzB4Ky8xanFQVmdOcEE4NnZoVWE5VmJxVXJEdnpoNlpVQ3BZ?=
 =?utf-8?Q?i2R8AsWx5nqJjxkiVHu34fW5y?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da7b6f58-eff9-4588-b91e-08dc84ec4693
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 23:15:51.2077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z1PKoxYUk7b2lMPKJax2v7IWDluLvpx6IqPyr6MHQdFG/kXYBYQIHCEjD8pYHJx+o52urKMFGKX8FV8FRlt7BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR22MB5863

Hi Vignesh,

On 6/3/24 10:41 AM, Vignesh Raghavendra wrote:
> Hi Nathan,
>
> On 29/05/24 04:21, Nathan Morrisson wrote:
>> Add three overlays to disable the eth phy, rtc, and spi nor. These
>> overlays will be used to disable device tree nodes for components
>> that are optionally not populated.
>>
>> v2:
>>    - Add build time tests in makefile
>>
>> Nathan Morrisson (4):
>>    arm64: dts: ti: k3-am64-phycore-som: Add serial_flash label
>
>>    arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable eth phy
>>    arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disable rtc
>>    arm64: dts: ti: k3-am6xx-phycore-som: Add overlay to disabl spi nor
>>
>>   arch/arm64/boot/dts/ti/Makefile               | 17 +++++++++++++++++
>>   .../boot/dts/ti/k3-am64-phycore-som.dtsi      |  2 +-
>>   .../ti/k3-am6xx-phycore-disable-eth-phy.dtso  | 19 +++++++++++++++++++
>>   .../dts/ti/k3-am6xx-phycore-disable-rtc.dtso  | 15 +++++++++++++++
>>   .../ti/k3-am6xx-phycore-disable-spi-nor.dtso  | 15 +++++++++++++++
>>   5 files changed, 67 insertions(+), 1 deletion(-)
>>   create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-eth-phy.dtso
>>   create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-rtc.dtso
>>   create mode 100644 arch/arm64/boot/dts/ti/k3-am6xx-phycore-disable-spi-nor.dtso
>>
> I am not sure if this a common practice to have overlays to disable
> missing components (at least I dont see such dtso in kernel). I would
> like to see an what DT maintainers feel as such dtsos can explode in
> numbers.
>
> Is this something that U-Boot can detect and fix up for the Linux DT?
We have an EEPROM on our board with information on what is populated on 
that particular board. We will apply these overlays based on that EEPROM 
data.
>
> Unpopulated SPI flash and RTC should ideally not be an issue as drivers
> would gracefully fail albeit with some sort of error msg.
> Not so sure about Eth PHYs though.
>
> Also, Are these dtso's mutually exclusive? ie can SoM have SPI flash but
> not RTC, have RTC and SPI Flash but no ETH PHY?

They are not mutually exclusive, you could have any combination of 
overlays applied.


Regards,

Nathan

>

