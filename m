Return-Path: <linux-kernel+bounces-179450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D888C6013
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 07:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 379381C221D6
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 05:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C314739FD7;
	Wed, 15 May 2024 05:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OITF06UZ"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2D036AF5
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 05:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715749956; cv=fail; b=RCNN9YFOuDhJMhw1mIRjwabujDy4VNY+OjhyzYzrNMKY/fG00id4yB36DsuJtcPEwsk9oCbRpKVPRGmS2ghu1DkGAifqAVSou3iELSeLVf/ycYJSNDBEGNb4me+0mQcM2hTq8SxPSe4kEPEgtWBcPUgYFsA1ohbS1+Ow6Jwba9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715749956; c=relaxed/simple;
	bh=tQha7liiRHX1cek4T9zosRCRMQw4g1HugLSwkZN5Fuw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m5kRM/iBVDnmr+HV5jLpnIPQ6M2hqNyPIYw5blefKPC2C0qj0xdh+RzLJXskIoqOjoHIR0ytlIr2qQWjnZhUmZusJ5ovlT9NJtM2x0YuOKlNLaOufFyCvb2pZFfVwHiXTAEaCQMwJclyQ4+AAeF7I/5Ekuh6wBHG4vD/TgswbGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OITF06UZ; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MB0qI7j9U+P6OLlNPG41+GSBMBhnQ1Yr/FY5T+KcOJ2qa/Nqjko5r/fhLJn1TpVRVNcyInQ4m/ellgYE6p+9rJ+xkVRv9/Rys84tfEGDLpTqy4AKtBEIsdh5ZL1IMSXED/xuKz+uwM+HIcs2mm3nkhVF5o3V6hV081ne8Az0DYWFyVhc5VLVAGcUoYihImcseDt8Vikzh+Br4BuLNp52VHxFe1+xSb+TbJLFbY6XOdqb8K2KwMTDsoVOLMHag39j2+r9iEI+b2DqW45d2W+uhzhBRJaMEBwou6YLbXMg0pyOxv64ouquejSqcGcdmH2B1JwzaM5JhBNrHwlK1w6n3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sUFRqvQCGMruYuf9h6OW/cRABARGaKqYCOEOoPvrPSM=;
 b=DMeF+7qW1ckyyoHVl2jZdJxuiOT+ThuM67OgZ8hJPjuKVfqTUKRl8Qssz9Q94iZvOXnqYt868Lwf/LJsBgmP7gNRtj+VpD/g/LS5XgGaU8IhvoAPP5p+uyG1nKUUpoCfg+4h2LfCKs8l9X+GsyVKRQ0xQBzENElm8vkWCTgTAiylcPJOz/YFbgR6HKxXEHv4POLTXmHFKBkDOG7E4cQT8wIT8j4s8os26lu3xJNNB1eOkeSK/XTC6EkO232Q74pzUQ6QPBrZd4yQe43AexiOxSA/umv2FHzTA2Ki8mwMYY/knsXsQkJNNdTAflcSifmyC6NmtK5W4XORFYUbrvylTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sUFRqvQCGMruYuf9h6OW/cRABARGaKqYCOEOoPvrPSM=;
 b=OITF06UZZro4RWIY7W8E1FULbJpVmCmWkTzFZT0FYcuLhWun/orOgYJlB6sIe4okO7VMU4sRGVNC12cQ7z5R5wLhkubt7TlM+6rXTqY1UoTeG9Gu3hCE4Tv/9GzI8jVjRh5hIcEJ8FPy6Apuw1jb9i4cGUHDJMJPU/b6qWnZlBU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6165.namprd12.prod.outlook.com (2603:10b6:8:9a::21) by
 CY8PR12MB8065.namprd12.prod.outlook.com (2603:10b6:930:73::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7587.27; Wed, 15 May 2024 05:12:30 +0000
Received: from DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::66b:8d4f:3f1c:6454]) by DS7PR12MB6165.namprd12.prod.outlook.com
 ([fe80::66b:8d4f:3f1c:6454%3]) with mapi id 15.20.7544.052; Wed, 15 May 2024
 05:12:30 +0000
Message-ID: <688af2f2-dbff-4941-93ec-405d3431dd01@amd.com>
Date: Wed, 15 May 2024 10:42:17 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND][PATCH v3 1/1] sched: Report the different kinds of
 imbalances in /proc/schedstat
To: Chen Yu <yu.c.chen@intel.com>, Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org,
 torvalds@linux-foundation.org, juri.lelli@redhat.com,
 dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
 bristot@redhat.com, vschneid@redhat.com, vincent.guittot@linaro.org,
 gautham.shenoy@amd.com, kprateek.nayak@amd.com
References: <20240514044445.1409976-1-swapnil.sapkal@amd.com>
 <20240514044445.1409976-2-swapnil.sapkal@amd.com>
 <ZkNHshuGhY6nBGmJ@chenyu5-mobl2>
 <e942abce-97ec-4bf1-8220-55bfed18c265@linux.ibm.com>
 <ZkN/7Wo4qVRmFQBU@chenyu5-mobl2>
Content-Language: en-US
From: Swapnil Sapkal <Swapnil.Sapkal@amd.com>
In-Reply-To: <ZkN/7Wo4qVRmFQBU@chenyu5-mobl2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0018.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::22) To DS7PR12MB6165.namprd12.prod.outlook.com
 (2603:10b6:8:9a::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6165:EE_|CY8PR12MB8065:EE_
X-MS-Office365-Filtering-Correlation-Id: d256b45f-c521-4fa5-77c3-08dc749d9e3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|7416005|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTJIRjh0d0FSbldlL2ZWU3pRdWFLc1pGa3NiVE80YTFNWHczbW9PMmVyQko5?=
 =?utf-8?B?TTdoOStZTjBUMmRLU0pvT1lkcEdndlVlcEtxYlJORjNzMmJFeTEzMm5ZTnEx?=
 =?utf-8?B?Q29qRncxRHVpcUhpSTBxSmY3SEV4Ri9qVGhXWmFuUFlKUWhucEcwdnJocjYx?=
 =?utf-8?B?TnQrQzl4TnIzWFJuUkRLU3Jhb0k1SUVERXBSQ0dWNmU1czFpY1pzai9nbEY3?=
 =?utf-8?B?bFo4WUJLbENISVZBNUZGNXNobkluVU9pb1BRdkNuMnI4LzU5WFJWalNRTU4z?=
 =?utf-8?B?dzVWT1hYN2ZqVlN5eUVlOHRIYkdIbWR2UlVRV0s2Z0hCVis1bUVWRjdSTzdt?=
 =?utf-8?B?WWpTSGozdXFqcjk0L1JaVVVjK2lHUVEwbGcxSTdUd01FWiszNTlJeEdaUzN0?=
 =?utf-8?B?NTBjQnlGR3c3Wmp0RWNVa1Yzb3V4clhDS1pESisweDNkb3FMeUgrRzV1bkhP?=
 =?utf-8?B?YjlDbUNsd2x6NmNvSE41UFZ6NlV5VHo5dmUvWE1OVUg5UytUS0h1OTJQTEpk?=
 =?utf-8?B?UUp6RDBYWDczNXpjZWFuTHFINUZZc1hqVU93N3cyU0xEV3E5MXpUOFVmNFpN?=
 =?utf-8?B?WFhNUjQ2MHQ1U2ZFV25sYWhUbGpJZ0MyZHZ0d2VnTkZNREpUZzJmNHdRajlj?=
 =?utf-8?B?TzhGd0xkeG9reCtOTTZPSWMzSjNicS9oYXlYUHpKMkh6a296cm5ZaElkTk0v?=
 =?utf-8?B?UmJsdGNDaUJSS3AzZUFrWTYyVmROdGNIeFFYQ2E4TzFmN3NqNkUrYjd2QWxt?=
 =?utf-8?B?aVJndDNqaTVwaU16eUp1QUdkSHowZjJJOTM4dEliWURGMi90SHU4cjdOTXhq?=
 =?utf-8?B?allJMjZhM1h5MHpJVkozK1dIZHh4KzhOR0pzcHpzSjFHZU9QSVVNSGFFem9Z?=
 =?utf-8?B?eDRFYUtGVDF6NHgxVDNhbUFHK3M4TmNGZkVhbktBZGlyeTZWeE1tZmMvckh4?=
 =?utf-8?B?QjBYajJkOTBWeVRDbGdZNGFQc2tnMG1IeExuYzNMZWVZVHhNYmhhQ3RncGh6?=
 =?utf-8?B?ZHFzM1pWVzM5NTBjRHNzS2QvSm9UWUhYUG5xa2EybkthL2h6S2JiU05XTDda?=
 =?utf-8?B?Z05YcXdiTGFRUDhBMXdmaDNPaWpOaEJsQlNGdWMzbWRRRmRYM2RsWXNFa2Uy?=
 =?utf-8?B?VVVTZDFHQVJGQW51TGZhblRSVDZ6bk9wZ0p6R21sbEZscFBJU3N0RE8rYkU0?=
 =?utf-8?B?N3pqUjFBbnlOd2FyK0ZseUk5TWJ2R0tPR0VxNEgwNDF0V1d2WG94a2RscHBr?=
 =?utf-8?B?eDAvMFRjdGo1MVpkZGlZMVM4UHB4a0tVQU5YeUVsaWpDRWsxdXVjdm5sSlRz?=
 =?utf-8?B?VXJObmJ0L0dyU2lXZUJ4MkJqZTRDYjAvaHdvSVRIVzRsWDhhdElpbCtHN0JW?=
 =?utf-8?B?WW5xQUYxSEd6YXdzLzFiZ1drbjd4MmxXdGM2UFY0Tlp3M25zSURDWVdjZ1Jq?=
 =?utf-8?B?cmhWS09CeXVxUXlRYUhwMEdnWGswV0IwTDlodkpGN2Y3NHhJNjBDeHpESlM2?=
 =?utf-8?B?MER5OGw5S2RiVXF1a3lqK3VoY1d0RjlKYzhNTFZMWkE2U2lsYmhnQlE4RzEw?=
 =?utf-8?B?UXdCYUJPeGVlcXYxMTJ1bnowYnl6Z2ZCOXU1SGZ4UDBUaFRSVHhrUkZvVVNt?=
 =?utf-8?Q?UJ4xDHQ3wx4LuxyZaUahd/9Qpg6rYJ1syUoW7n56YmBM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6165.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUNPQ1llbDNyY1lhVXd3eTU3d2hvVC83QzFZRzdMRlNBZThoUEtjNGJoOTNM?=
 =?utf-8?B?UDVQNXUyZW1OV2haai9YYno5dUlWOEd4cGpBZGRiUXQrN1c3cC8wUlNCWmVy?=
 =?utf-8?B?MkVCb2pLZ0RPSW9BZDY2NkpiRUpHc3pBU2ZEMERQRENMSG56QjZNUWhubG5t?=
 =?utf-8?B?STIzdUVWNzUxNGwxNGYxYzZ0VlNrWDJvcVpYT3Fla2JNYkViZVNtaCtac2F5?=
 =?utf-8?B?YWE0SXFHZHQwQStQYXZFdndqUVRjS3N6Y2UzbXd5ZjY0OTdtMFRwVFU3eno3?=
 =?utf-8?B?di9lNkNNUDV3aHVZckE5SHF5bDAxZVBiblpQQVBGeG1yUTk1eFhDVWd6NUZE?=
 =?utf-8?B?djN5QlY4aC9BUURuRzcvOUNqRnhjREY4aWUxSEN4T2VhcmNjVGpUY292Nk5U?=
 =?utf-8?B?am1na1MvcFE1R2VFNXRnd2ZTMy9LUGFjdVNzckVlaXdIbkFDVSs2bnBQbHI2?=
 =?utf-8?B?NFVNamVaMTR2T29xZXh6NjFxd295dXFMejRrbVdocWN6dVlpcWtxTUpOaGwx?=
 =?utf-8?B?czNjQ2ZUT0V5MXJ1alpXWXo5ZkluUUZtUGJSWnd1ckFtQklxOXVTNHVXQjJH?=
 =?utf-8?B?eDNiWXg4TmNsWXRDTnBERDdoQ2V3Q2hFbjlWWTdSQi9FQlhMcFlnbzhkRGVJ?=
 =?utf-8?B?VWdHUXYyUzNEU3ZJSy9vYVp3QlZtcGdNT0p3MVF5eStZWGtmN052M1ZNNmp4?=
 =?utf-8?B?UURwREpJRGVQazBWNHZWeVNLRk5MZ1dFWmpjdklNbUJvcStjZmJBempJMXhm?=
 =?utf-8?B?OFE1K3VLckJ6MjRqeTR6MDZPY3loSE4raFAwZFVwVWpDVHpKd0k0cmxLMm5n?=
 =?utf-8?B?M1RHb05NTnVHTmVNZG5oeUhRelVSVDlOSk0vWGxoWE5RNkVBczB3ZSs3UG8y?=
 =?utf-8?B?WDA2OVZHNlF4aWhQbXBrbzYxTDRveU1JNWxwQW9oTHpsRGZKeDNXZDNKRUl1?=
 =?utf-8?B?a2J2M3pvSW91UjMySkNwZnc3blNFREdVMUp1ZEhJQkVFT2RNTmtBQ21FczZE?=
 =?utf-8?B?d1I4cDNzNkJTMGhQVEpCVmlIZlN4ZkY0M04wQS9DUWhOK1VZZGYxdHVISEZN?=
 =?utf-8?B?OXBkUHo5RklYb3ZyZTdJU1YvNkFEaXNydllRQ01TaTUvV0QrWEVVTWc2SnJJ?=
 =?utf-8?B?NkE5bWlmZnRHYm5UUEdvQTE5RG5HMnptOE11ZnVGL3Z5UHZieUJGUm5IbXFk?=
 =?utf-8?B?MThwbVNqSVVlN0ZxbkhxSmhnaEp5aDBRdm54NVV3VFpuY2VxL0VQYysveHNw?=
 =?utf-8?B?czhDd1A3ZG1lTDgwd0FRekY5ZFU0aWsxUklpcE1sYjA0bk5GZE5GWjRrQkEy?=
 =?utf-8?B?WlYzN1VEL2lzN0ZhQWlydldHM2RwT1BDVzhSSFpJZDQrQ1RRWnZtbDdqanp1?=
 =?utf-8?B?TWhuRU9wVURjUExyZXlGbzJoU3N0M3pJM2tKdTNXdVVGT3BYNXFxMTV6bXlS?=
 =?utf-8?B?akVQMFgvdEVDdEpDZ1F0WkkrdVprK3dhc1hidkFxVEhwN09HNEVrRHJVNC8x?=
 =?utf-8?B?cE9ZQlo1Mlp3TFcwbmY2YUp2a2ZOZlNnYnNGdDMrVXRPRVRGWnBWL0QyUGt3?=
 =?utf-8?B?SGdQQzZGbGhLd1JaM2pTa2dlS3lJWnlGZG9BaGI1clNTcXJNMFRoL1RZQlFX?=
 =?utf-8?B?MnFLc1UrNzlXWVhNUXRqMi9MZlRYZlM0S2VnZjlCYVh0WVhXdUMxa0pmYVJh?=
 =?utf-8?B?dmVsOWRNaHFCWlRzTDN2U0RPVTRaZFM2T3BZOXJQOWNzUCt2SFdldVNrUkFu?=
 =?utf-8?B?Z0licWZGNUJsWDJpeVVqUXJRQjBFcXF5cnpWbGpoZUhrTEpRMk8zb2kwQVd5?=
 =?utf-8?B?VGVZS1ZkZ2w4bXlDaXZNY0tlQkpXN2NuR2Frb3YzRFd3ams2eEFzWUxRZzZQ?=
 =?utf-8?B?bWRqL0ZxNDVBZUp1NHYrQjJrdnJ1dllxSkU3UUhhSkJJUzZnb3lXa053ZFJ4?=
 =?utf-8?B?akIwZWpEWG56eDhKdXZ5UUNFQXFOWnM4cks4Wkhia0Y1VHVDalMvaG9DK2F2?=
 =?utf-8?B?TnE3TnZoM2dPODJJWHMwa1NXbGd4YW9TSnlXQ1d2a3RzanZyblk5SGcrYWlO?=
 =?utf-8?B?bGZlRVhWa2lxT0JrcStnWU9XQjB0UWVWUmZwS1l4UWxXYlRjS1NldlN1MkRT?=
 =?utf-8?Q?8GWdi2VXhU6FzXpfEaazU9HAe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d256b45f-c521-4fa5-77c3-08dc749d9e3f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6165.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 05:12:29.8254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T2CEsiT6HYehakSo12C6I6iMik9YUFZJUz62OtYkWkUserUPbPaGRmd0/fOKqFj22hhWjcr5vQkI78qEqg00MA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8065

Hi Chenyu,

Thank you for taking look at this patch.

On 5/14/2024 8:44 PM, Chen Yu wrote:
> On 2024-05-14 at 19:53:58 +0530, Shrikanth Hegde wrote:
>>
>>
>> On 5/14/24 4:44 PM, Chen Yu wrote:
>>> On 2024-05-14 at 04:44:45 +0000, Swapnil Sapkal wrote:
>>
>> It's been increased already as part of below commit
>>
>> commit 11b0bfa5d463b17cac5bf6b94fea4921713530c3
>> Author: Ingo Molnar <mingo@kernel.org>
>> Date:   Fri Mar 8 11:58:55 2024 +0100
>>
>>      sched/debug: Increase SCHEDSTAT_VERSION to 16
>>      
>>      We changed the order of definitions within 'enum cpu_idle_type',
>>      which changed the order of [CPU_MAX_IDLE_TYPES] columns in
>>      show_schedstat().
>>
>>
> 
> I see, so it has been increased due to commit 38d707c54df4, and current patch
> is accomany with that.

Yes, this patch accompanies commit 38d707c54df4. It updates the documentation
because of change in order of [CPU_MAX_IDLE_TYPES] columns and adds the imbalance
fields which will be used by Perf schedstat tool[1].

[1] https://lore.kernel.org/all/20240508060427.417-1-ravi.bangoria@amd.com/

> 
> thanks,
> Chenyu

--
Thanks and Regards,
Swapnil


