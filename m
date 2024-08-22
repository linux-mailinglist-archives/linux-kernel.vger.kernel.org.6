Return-Path: <linux-kernel+bounces-297036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD7F95B21E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 11:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D38FB228EA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 09:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A63A185948;
	Thu, 22 Aug 2024 09:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="qIeS/P0q"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2086.outbound.protection.outlook.com [40.107.117.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B33183CD4
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 09:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724319710; cv=fail; b=F7dPTjXHrB0gLEx53DxHC1ZY75Vvd+rvYliYLwd/t1tx5aNJQHwc6REp1t6+Vv5UaloBghvTZb3GOFOzo4+f2eaLIqE6lpTQyB6WMcWHDKDAJEGGiG38bM1YW5z+wV8SgzPRdwrqnL5nbXGU6uXZ5q8y8a2yCfaybLN8U1K8cnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724319710; c=relaxed/simple;
	bh=epmVl22SLlYixe7/vbDB4wSUWmqP3TuUhE12spdzuYM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U+DmoE7zEjiAhbKhnWll3hXP7ZU4lrtnBrmDvNtherT7J0F1yzBSU4sk5sPo4BQqi5Kcch3GRNMx4JKUBwWN/q0W1VupZdhJC3OrkCs1qxgW8Z+G74475pef0mHULAkYRAAqxh3gZcWpIQoJMP7GcBGskuwi8I2CZfkiA6c1+8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=qIeS/P0q; arc=fail smtp.client-ip=40.107.117.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HotysaToPBMIBCpzYiC9DYs3KRRQUMFGESR4h4U9gCkziRjj/Dz2bC2KphfaHQL8ZyFR9Dz0MPjUOnaFaP48Sq18bNO9/lR7n8afkKQJCFk/2NkLXkJGmIhGrlKnqjvXhmL6CzjSwSU/t+8Eylt8vK3ap2kOnkBnyZSufXofzF6yAp52Zp60gKkKs7zvvrtaJ4wulaRhDuZV5NoL9AOCC1gNYgpW0OynEOl+u3gTKFm24cQX188DQgLUlLPhrnztlaTfVt5qOOJ3CR37Ffs6zpmcCtFyHRwWHl54OinshW+6EMO5lqmvPy+wLMze1s9yztGMXBljrmra4VY7YJfWcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fLnqoFne9A6FrP9bEcx984Tj08olziQScLmlyI7gxoI=;
 b=jPn9vHeY31xH/GdQZG+MSrOmdJuWXaC1WKMGD+fI/smYvy39qY23eVjzdCG6rjNK9DV07aOQOAmSBn2SEBnIyjjcyhlWDX0T/Dau9ynnsErM6bxiHdVLSl3CrYU5qsdrwDjn4Y237350mZNMy74MODJJjsKc5nCtwi22OJsGIjgmrF8RHMbybeL4lCnFupWmaHb/O3B1UfCRMjdH9RWfUYptTyRQT7PS1j8u7Sop/ZgBMLSjo77FFQpTbS29SeK8D7nehFf671ZX7le5W6RdMN0BWHUSsZXxk55LmNYy6xYpX7dH7KjU7PmUehZ1aOe+h7s9611xZ87TacgU9I7PTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLnqoFne9A6FrP9bEcx984Tj08olziQScLmlyI7gxoI=;
 b=qIeS/P0qyLhEnfX4re6jrxZy4OnS8wahhrks22AjyHgmHsmDop381wjcncHB6Rs6wDbJr6IfAqGVTQMa2eaEio7F569/f4HGCQ06ZBJpomZZsDBVNY5vzczzm9Uq1Rz+GlwjqQZC4IDSps05/bc8JwRW95te1MjvZ3dEVDDTrUBtHiFUuyT3QcYQ3BvDx+D/WThOa85MlFBcxcAjUSzQFih+uv3JTpQP822OOj/jAcqESiGKFHJZb84i+OUA/WG7Af/hYmvhGQe0XrXGqyRs0CmsGiL+L8WJuIX3t5ftiX5n5+4OgaTrzh5T7Z+yrDWcZvU6H5zxefjcYKW3FevQGQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com (2603:1096:400:33d::14)
 by TYZPR06MB5122.apcprd06.prod.outlook.com (2603:1096:400:1c2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 09:41:46 +0000
Received: from TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268]) by TYZPR06MB6263.apcprd06.prod.outlook.com
 ([fe80::bd8:d8ed:8dd5:3268%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 09:41:46 +0000
Message-ID: <be61331d-5ab0-4755-823b-f8420e8e79ee@vivo.com>
Date: Thu, 22 Aug 2024 17:41:42 +0800
User-Agent: Mozilla Thunderbird
Reply-To: 11162571@vivo.com
Subject: Re: [PATCH v1] drivers:coresight:Use min macro
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
 Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
References: <20240822073600.1359333-1-11162571@vivo.com>
From: Yang Ruibin <11162571@vivo.com>
In-Reply-To: <20240822073600.1359333-1-11162571@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:3:18::34) To TYZPR06MB6263.apcprd06.prod.outlook.com
 (2603:1096:400:33d::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR06MB6263:EE_|TYZPR06MB5122:EE_
X-MS-Office365-Filtering-Correlation-Id: 1091bbf9-a3b0-4f02-c7bc-08dcc28ea32d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|81742002;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cE1xemp1VE1VZFh6a1JCNkRBREVCNEgzM3FrcEFyTjFWdzhnTDZPTWNBR05t?=
 =?utf-8?B?b2VkZVUxc3psYzhEbk9MNCtnQ1N5aDFVQ3o3dktyS1hEdWYyVWtmSUU0RUZB?=
 =?utf-8?B?UUljMjJ1a0VuMDJFQlBqM3hJbDNRWUdsYWtQdGZzVm1JZ1l3b2RoWWQ3aUNS?=
 =?utf-8?B?MnZxanBod1BZQ1paeWxtMUtkQnJlMGNJQmJEcnNycG4zQ2xUcVJKT1JBelpM?=
 =?utf-8?B?L3k5bGZiR2RLWUpoZVhLcFh0T1k4Z2JCTEdwYzJ1bkpyN0JVTk5HQ29STjFq?=
 =?utf-8?B?c1BucXBBSnBwazNXUkFzZnZEMTkvWjJYTkxTWklIcHo3SFY4SUVnTngxZm13?=
 =?utf-8?B?Rk0vVVhBQ2VReStRUHNqN1NOQjB6RHZsSHBhMWxlWjZ0RlUwa2lvZk53T0da?=
 =?utf-8?B?ME4rVnZwNFpGaHVVU3FhakYxWCtqTG5UNno2V05GMmI5S2w2emZiN0NaWitx?=
 =?utf-8?B?NVB2QTZTd0Y0NmJzMndpSnJOS1ZDNU1veFF2SS9LSW9NM0c2dVRLTjJjR2lH?=
 =?utf-8?B?RXA4MG1tTVFOQnU4dkNhUjFyRkJZbkIyK1dPR0trZGRRcFUzbTYyak1DaU5l?=
 =?utf-8?B?K0F5YjRTTWRBeDN5VERxbSt3SnJwK2tUSGNWR0R6OGRWUHRGSUNyNG83dnhJ?=
 =?utf-8?B?UkJSREp2VCt1SmIzZWU3YkNqZTdVa2JBZklRS1RaL0hiempsbHFnbThtOWtx?=
 =?utf-8?B?ZDgwdjlnK0JOTTNPVDErY1hmTEdCdXlSZlpERVNka0xmRmxia3BHSDNMUmVn?=
 =?utf-8?B?L3N6MFFPNkM2TWg1bDVFTngxSnhYWkNtUWg1dVM2VDFoWjRUZlY0eGUzWXhG?=
 =?utf-8?B?b1JvejdDa2xpNWg0OUhGMjJ1aG4ybHQrSGI1WGwrNC9iTjZXS0t0ejJJSmNB?=
 =?utf-8?B?eWF5TUI3dnVHUjZuSC9tYnhRckUyOW5DdXdYSnFTQ0I4RG9wZkQ2K2Y1UUo5?=
 =?utf-8?B?ZjFuVUMvVWZXcGRkSVI4M25CNjJxMWYvRlVSMnpMZHFwYURRWWpsbGZkWTdo?=
 =?utf-8?B?MmJUaERqUVpIeGpHajlSNHZpeURTNHV0MjJiMWxsQjluck9wV0pZdWQvY1ph?=
 =?utf-8?B?VDZ2U0hMa2NNSVorV0N6dWc3d1ZHNVRBK0hOazdWb044WkdNTmVVcDNMRVp3?=
 =?utf-8?B?VlVvRm1tRzhlT3RFK3d4bjZXTU1lOW1uS1NKbk4wd09FYkZ1TlJTWnp1eXY3?=
 =?utf-8?B?eUFCWCt2dWpTdFVVUlBmazlTc05CYUxvU1VwYVVoU29Gb0hSL3ozUDF1V3lr?=
 =?utf-8?B?aHhEZVlKL1huemZTN2ZlQ3Y3Q3dQNFM2ZDAxM2pidFd0eFZpaFYzRkFBQjBm?=
 =?utf-8?B?ejhlNHhGMmVndXdubWlzZlR1Z2h0ZmEyVnowWkUvdnB1OGZLUStwZDRUZk1M?=
 =?utf-8?B?SDlLMzVsb0Z0Q3o5V0hOZ0RqL21FWXBsazBBbW1WcnlqTU9vZ0llMTJoZG1T?=
 =?utf-8?B?U2hCZ1hwMlRoYkh2bXF6R01SbGVIdSt1Z0FsVkttaCtFU3FRMUNVZ2h4ZDFM?=
 =?utf-8?B?Z1BFTWVsV1NGVlhuSkl6cmtWVWxXZldTZnpNckJQV093bTVnMnV3dS91WW5Q?=
 =?utf-8?B?WlRmeTduTHRlTkVKUkVMaEpEWUFNcEVLZ3JHMFFzcUtmNVBMOGo5cWhRSVFy?=
 =?utf-8?B?K0hzWVdzUXlnTXQ5bHpaS0JiditDaWdEa1N1a0hyOVB4MmRPRFcwMysxSFd2?=
 =?utf-8?B?QS9DQUo5dEszbVJ4UGpGdVRKTHlVaDRYYlRGRU94Q3Rta3UzbW5VS095a2lp?=
 =?utf-8?B?RjkvT1FUNUYySURNb0oyNVA5eVlOUjhSdDQ3cUMzS0NSVXA0SkdoNnFjLzhZ?=
 =?utf-8?B?YjQ2dDNzbW1ZMUJmN0xFVDkvSVBSMS82Y0JCT09XeDlZelZ4SXA2bU9zZGl1?=
 =?utf-8?B?c3RMQ1pORkdnTGxPekEwdGFPSVkvQUFORk1pUGtrOEpoU1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR06MB6263.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(81742002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K1dZTE1rNXpCdDhiVWhQWmJTSW4xbzkwbS8xQXVwNis0TmRsa1IrOUdQUElW?=
 =?utf-8?B?RldKUGJBN3hQYmNXNFRTRWdHREVvZ2xkdW5POWJQT2hOYlEwdzVTenFQRnRI?=
 =?utf-8?B?QW9PenVFZGk1TXN1eGgxV2J3NUZBMVRLN0lOWUFhMCt3K2ZmcXBsQThWNU1h?=
 =?utf-8?B?WWQyY0hJSUQxdVM4SVU1MXA3R044cTM0WVdvRmszeHNQOWFNSzRRTnA4UmRa?=
 =?utf-8?B?aFoyazlpcmdvcWNSQ3M5S0tueTRUaElhQjRsK0hvcjdab2Z0Rkh4SnhrTUdU?=
 =?utf-8?B?NlJ2WDZGVzVUOG8vZHpMWUhIQ2RCSGttUERXYmdObEJPWTNRZWpUMWdHYTdE?=
 =?utf-8?B?ZFdsMWRJL3pqS3k2QmVDTXcyT1lDdHJTSTloeU9FWlRkNVJLeFNiK1Vud0Uy?=
 =?utf-8?B?bEtkRmZXaEwzV0h2dnNReEp0MVhTQXN3MEx2UVhmZGU5dWRiS3U4R1JxRlh2?=
 =?utf-8?B?b2xEZ3RaMWM3MmhSNXg1RWU2RHFBK3gxaC9QNkwxSy8yTGN6Q3V6cGdORkdQ?=
 =?utf-8?B?bnc2amxBUmtSVHAzZVFmL0hhM0ZIcVVGalNMN3N4aUNac2JiVERzZUxwbHBG?=
 =?utf-8?B?cC9kZlU2SDNWK1RjQTg2ZVNtd2hvWWJDUDJURGtMUzdjUm90RDIyRzZvOTJr?=
 =?utf-8?B?ZUNDdVJLRWdWSFA1QWpGRnY0dTVEcHpPM0w2T2x2dWpoNHVSL201SGo4YUUz?=
 =?utf-8?B?YnZqYnNGY3BSRjl6S1NmM3FrNEVIR3VzSXJRR3hnRGNaaHlQdVV3VzgzdUhE?=
 =?utf-8?B?V0xsYWdPZjhmdURVd2czMXh1QjJ6aytBNjhSaVlLTTFyZkNyYk1GWndnUFBT?=
 =?utf-8?B?VExyWWR5anV4bnBhdzFXdWY4YjdmS0piREJueThyY01HcEdUWUxHUjZOQW5w?=
 =?utf-8?B?UDh5R2NhMGg0d2NTQ1dqK0V6WE9xR0NlM0tDVUtpdlViSkJHb2l5OGVVVkVY?=
 =?utf-8?B?b3E1ek8xZDNXeTFnSEw3TzZkY0VPc3RCbHdBa0VuQVhOYU8xL0d1YkVFWWYr?=
 =?utf-8?B?a0tmWkJRSXQzcDdvUUlkZHBGQ0V6eVUySUFZRlU1Z0duVlZYc1F2VnArVC9q?=
 =?utf-8?B?anJxczB3TVFjUjBqZjJ3SlVldVpCcW50L1lVZHRmd3N1VGFWSlhGT1FsS0k2?=
 =?utf-8?B?Zm85bUk3Rmd3QXBzSHpEUzRsTG9nbVBEQ0tocGRnTFRUTVUwaFhCRHZtVGJ5?=
 =?utf-8?B?S2dua01vaGx6cTkvWXpYT21weUhtUFlFL3pwcTlrODgrb291WmZtdU9kM3lJ?=
 =?utf-8?B?OGY1NDNXWXlsTzNGQTdtK1I0WE0zdFdPbkxmblo2T2FXVEw2dmZnNEpnUzJu?=
 =?utf-8?B?aWxUcWY5a0ZKWkZOa1JPZnB2WklzbTlvOEZvMlN3aHY0R1N5cVhLVXorYTVw?=
 =?utf-8?B?YXBZR3FlNEtOUkxYNG5iTHh4Rmg5WmRyYTNnTlZ6UzZZd0h3MCtHWWRMZ0Rp?=
 =?utf-8?B?QTJyVXJqK1FZcmIxcWRpeUhPdWtmMkpoT3BuY01iM3ZRVFVSZU14c04yZVQ2?=
 =?utf-8?B?Q0hQSWdjWlJibzVPTkdXL1dSb0tUSVlEdVJHYXozUU1uWTVtRTlpNzRlUXpI?=
 =?utf-8?B?MHl3S3FUUnovWi83NEFiaFQxYmpESjBCSCtlay9EL1dTOWs0RTgvWVQ0RlFV?=
 =?utf-8?B?NHVHb1dVL3gzaG5GZ29udlhDVHdTZW1od3F6R3drYTUrcXk5YTcxaGRDTWp6?=
 =?utf-8?B?QUFZMjhaVmhheHJ3K0RSZEoyZllKc0w5L25EWFhRbnNRZ3AxUWpPWkRNakg0?=
 =?utf-8?B?bk1GTTNGQVNxclEzUjNmQUxHYjBvL1FTSnVRbmFqOGlOckNaS2U5Nmd2Tnkv?=
 =?utf-8?B?VTZ5bnpITURnT1kyZ1JlUmVLV2d0NXBNcnViMDVNcFpkSHVrTFV3Rk1QYi9y?=
 =?utf-8?B?ZjFaU3BHcU1kOVlOS293WS9EMlE2N3JsQlBmTzVEVjY3dnltL2FhSHBpODdF?=
 =?utf-8?B?V2JKdldURmlKcDdyOWNmM0gyNzk3YmNzSUxvc1FabXBXZG5nek9vUlExNXpF?=
 =?utf-8?B?SHpSdm1Wd3pHMHBVQ0JtajRmSEdxdjJpSzloYzI3WTQ1eUxhUWlnQVBOQW9u?=
 =?utf-8?B?NldmTXBmT2dMejRWWXZVUW55eENuREhaYXpvZW1Db01IU1dzK285QUtvWjNW?=
 =?utf-8?Q?DAj9cN2fdrZtUODAL91Kf9FTd?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1091bbf9-a3b0-4f02-c7bc-08dcc28ea32d
X-MS-Exchange-CrossTenant-AuthSource: TYZPR06MB6263.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 09:41:46.0119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aImqDKvNiQzAoS1CeH187PFADOALIIBJ+cM90WekPzVExfF9eDW9M+THMniOK+fZ/0hCOvWDRQQXNEheLaOVfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5122

Sorry, please ignore this patch.
Because the corresponding header file is not included, there may be 
compilation errors.

在 2024/8/22 15:36, Yang Ruibin 写道:
> Instead of using the min() implementation of
> the ternary operator, use real macros.
>
> Signed-off-by: Yang Ruibin <11162571@vivo.com>
> ---
>   drivers/hwtracing/coresight/coresight-catu.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index bfea880d6..7ea67d56e 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -152,8 +152,7 @@ static void catu_dump_table(struct tmc_sg_table *catu_table)
>   		catu_table, catu_table->table_daddr);
>   
>   	while (offset < buf_size) {
> -		table_end = offset + SZ_1M < buf_size ?
> -			    offset + SZ_1M : buf_size;
> +		table_end = min(offset + SZ_1M, buf_size);
>   		table = catu_get_table(catu_table, offset, NULL);
>   		for (i = 0; offset < table_end; i++, offset += CATU_PAGE_SIZE)
>   			dev_dbg(catu_table->dev, "%d: %llx\n", i, table[i]);

