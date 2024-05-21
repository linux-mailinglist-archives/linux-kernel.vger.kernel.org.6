Return-Path: <linux-kernel+bounces-185289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCD1E8CB31A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 19:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E3C31F223C5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 17:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4651442F3;
	Tue, 21 May 2024 17:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IV7XKCGN"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496FC2CA8
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 17:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716313743; cv=fail; b=G0mCbWoZaJ2K4KOy2nCh4TQ8VNQS9hNn7/Fe6dvAaXeEwjQcwCL9fKExCNZT4GTjM/IOYXfKHS8RcF2GbXfNKvP2DLgNNDgKau+/+sj4WEAEjrGUOqbnHqHHwVgTIRjalGFeZRepeXjAv3Bnh9t1WigtIqZGoodLDjLDIdxunfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716313743; c=relaxed/simple;
	bh=4ov9EdQvvuM0bncKvxrHdgWhEPGIIb1APAUJ27v71Vc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FRzh2ZPaSt98Y6U9BMutkGRtqWFYxjOmBRR0gE9rix0ImFrnfE2sTivX77FsNeRCdQKqxTls93IPb7Mz6IGBJF3er28/gfa9cS0d3Y0wbmCZDkyyZm1v9AGd/akUR1l8gNQGHJjKLt3k5+HuIWy42FxULo36Wc9Px5fBxdYwC8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IV7XKCGN; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ILzCMPJOcJ8XjYtQM0bpxtSNQFyZpNfsmRc1GhbbYSq4ifJjXichvo2VS4oHSbP/QktkgbjTfDYu3+fSAIr5IjE8L+4jCibLQVR6q1944eV29yATrIE3PC2PoSdbFkb6dNEzDLa2AsZ5DgaDAVX6iIQza/jnCwh2r7GYNb0iD/PBh9EtdVIjy2FbNoZjIo1xIoMm50UlCTcn2dsdGro8s0lVDIQ5dbSXPzU8iXy6eY9WCs0V8w/95t/hqneeDS84P4zitV5TVov6GiHW8tkHCC3CJbiQ14b0aMACClzcxrKPZSeZibVbA91QzzalrA9on4E+Ku4qy6377QaZ084LAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhSK5renbevzyD1c7EH+oFhaHXFbKE+kAf7WrqFWEWw=;
 b=TcyWVUHwFSvlXLU9yUj38FS3eAL9QQxarXmvfw42VGJpTUcT6THmavO7HbhYjNBiCR9MJsZ9vBBaIQPMWsp9czYraKpDVwqr+K6eXer2cZ5Z2I/AXh8oRwYBWpYH8cc+WKNsYwRuYjus3CKcR0rjgKq2M+FOYDD1BpjvzflOTWexAytfzj73o9Rs4JeK5bkyV+xcICxS6L6toFDCYNLSpTicrpABG3ME9x6SnCAwDNjbsGiGEqifQS9waxXKZHkIfSWEIHU4pKTUi80K+TAfu1S0m85fmto2o25yg9VdiU2bhacZ0pwHOo+430cLToK1GLjlG8JIvqBK+kn9kjmf3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rhSK5renbevzyD1c7EH+oFhaHXFbKE+kAf7WrqFWEWw=;
 b=IV7XKCGNFweFfzzut4QjdLTlp7OUXGUrpF0i9IKbFueUwaM+i56d8xLnufA5hGLYrP3Ghk1qh2eMznUV/YeopkuDq0SaNXh4P577c6e0KCO6eK2fY7Nb1bDmlGs9c4oqcpg20ajv6CFypifRVIPWUonwpgzQpNaUldh0XubVBgk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5874.namprd12.prod.outlook.com (2603:10b6:208:396::17)
 by DS0PR12MB8220.namprd12.prod.outlook.com (2603:10b6:8:f5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.36; Tue, 21 May
 2024 17:48:56 +0000
Received: from BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::5a16:a4db:8bed:1f5d]) by BL1PR12MB5874.namprd12.prod.outlook.com
 ([fe80::5a16:a4db:8bed:1f5d%5]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 17:48:56 +0000
Message-ID: <a18ecb3c-8c24-4be7-af59-1413f4989cef@amd.com>
Date: Tue, 21 May 2024 12:48:53 -0500
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] drivers: mailbox: handle SGI for shared IPI
To: jassisinghbrar@gmail.com, michal.simek@amd.com,
 "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Saeed Nowshadi <saeed.nowshadi@amd.com>
References: <20240503141545.495112-1-tanmay.shah@amd.com>
Content-Language: en-US
From: Tanmay Shah <tanmay.shah@amd.com>
In-Reply-To: <20240503141545.495112-1-tanmay.shah@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0042.namprd11.prod.outlook.com
 (2603:10b6:806:d0::17) To BL1PR12MB5874.namprd12.prod.outlook.com
 (2603:10b6:208:396::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5874:EE_|DS0PR12MB8220:EE_
X-MS-Office365-Filtering-Correlation-Id: ba3642a2-5c89-4d37-ad0e-08dc79be4959
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ODEzdmhhSkdHd01ucnhScFc0SG5PUllCNllIclRNOTBzWVd0RG1UNzdRTSth?=
 =?utf-8?B?SEVPUEdwRnU5alRMRTlsSFVWZ3lqcmpwMjBINjFYSzRreEtCeGI2VGlkcTRy?=
 =?utf-8?B?akYrME1jeWsxMm1tZW43bE5JK0hjU2c2ejBINWlLSjZOM3lxVFlYVkJpdnFS?=
 =?utf-8?B?S1djTlZYN2ZiM2thRkJ3OUEyM20zc0VIRDQyRzNybWh3WTRER1ZRNkRwYjh5?=
 =?utf-8?B?ZDJQcFZRMkhmViswTlFTa2c4aGlxRkw3MVRERDRnZmZaNWF1NzM5bzNWT2JP?=
 =?utf-8?B?MitKbDUwYm1mNElnTi9CWEYrNXpzdXdCOUhoOG1RSEFxOEc2QjdiZzV3cEov?=
 =?utf-8?B?dS94S3FWK1FORzZlVlF0Y1hqQkxIZHlWbGF0NnNFd1ZWY2RkMFIxMncvaE91?=
 =?utf-8?B?NEVPQWpoMklTZkZYditDWGErbU1kVUQwSVJrbWkvMzBsUWw2RmNRRVozREM5?=
 =?utf-8?B?bFJUNkVjbmh2SmJXcEJXY3VYTjZpa2NzdlJVc2MvRzdVaWRHakhldnVudVJz?=
 =?utf-8?B?Mjd0N1lRc1A2STRBaW83NWpqbTBMNkxwYi9VdjlkR0FNWDFsR3l4T3l2L04v?=
 =?utf-8?B?L1pzeEpOeDBNU2NzVHBiVEY3SHZvVVFLZHhUdGl4YlBXQlhjOHFrQmUyVEJP?=
 =?utf-8?B?ZEJENkJVcElMR0dheU1ZcjJUaDc5b21qQ0daNEM4UDRHdzY2ZVNBaDV1MDVp?=
 =?utf-8?B?elU2SHNua096OEJNMDNZRzdFb3hKdVJyRE1EcWpBMVRZelMySzQxVDZhc2g3?=
 =?utf-8?B?cDVFSk9nWkh2d2lRZmRmSndIYUNLejV2UGlFWEoyNXY5eEhQYmdGSUlRQy9L?=
 =?utf-8?B?bE1HSHJRNEtmVWltRjRHSC9RMHExOWd1T2pkdXdhMDZ1R09pejdFU3dRYzhW?=
 =?utf-8?B?RjVZMDA5TERZTU9QSkdkdE4rRmNkR2xvdURKakhFRWdHamw2Q25jdmVvdytZ?=
 =?utf-8?B?Z2xFVHRvZ2dWbllRekRST0JrdUlFenB2M3A5a0pCUnUxYWJHQjJlWHNFV3Yv?=
 =?utf-8?B?c1FPMlpNN3pLQXlwUmYzVFhBb0k2S2F0Vnl5MkhHZ3FZcmZHVGt1clEwY1lH?=
 =?utf-8?B?dkd6NG5pTHVsUGlxT3VsK0FkMEJFYXlWbDhLYmoybDZZN2JmMGNsMUdXTysz?=
 =?utf-8?B?ekdMYWZjOTVGMnE5c2ZYblViZitkM094WEZoUjF2UzEweHhZck1FOVBCbVA4?=
 =?utf-8?B?KzErQWRPU0JuSEFXaU90WU45bExTem1rQ1psQ1JxRXE0dHliaHJtTXhnbmMx?=
 =?utf-8?B?TVBSb2VmUG9XdmdJbUZZbmNVSTM5ZTZNeG9ncGlBck9hNlVBeTkxcThWRjha?=
 =?utf-8?B?Q3dGSzlDNEt5NWEwRjkrUVdqeG1kQis3MDFKS2drMUp4QlN0U3ZxVDhmcnNU?=
 =?utf-8?B?ZDhVdXZoUnFYMWxLNjVYS3drb1E4MTBEN05ZZWN1UVM0c0dSeURQUGtwVTlO?=
 =?utf-8?B?RS8wZTNyR3VmVWpXZlQ2MVV1ckx4TWN3c1lpMjVVRUNwamd4SENubXNnZTBC?=
 =?utf-8?B?ZWFDRjNXZExGY1AzWUlpUlBoQU1BTWp6UlJRL1FlN29UbUV6QlFmcE1TUVF3?=
 =?utf-8?B?dWJtMnZHMHlYQi9LeHhrTkRjaTMyRFZpMGpiWEdRMEg4TkZXTW1PbXBFdlVj?=
 =?utf-8?B?cGdNQWpwd2kvWUZSSlNpaWpkdmNLY1NaMlY2UGRkOEFnNXdId0FmNUcvSytI?=
 =?utf-8?B?bW1xK2ZwNU5YRUtuTEpBdFVNdWJVL0NrUG5tdEgzVjl1cFlFUkU2ekhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5874.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SEtmZllWY1BwVkhkM2xPeFZvaDlpMmxTd2NYbDBsK3ZCK2F0UUlvNFdNWlBT?=
 =?utf-8?B?TGw5QWt5SkRyajh2K0NXOTZZdGFoak16dlBsaWV3WHoyeXJ3NUJPTW5aZW9Z?=
 =?utf-8?B?d3RVYnVOWkxRWTVDUmt3QlNhN1NIZmlWZlpGNWhTMjlQa0JYS29FUk9udjIz?=
 =?utf-8?B?eHBhVVB5Q3QyWlRQZklLRkpCMjd5V09LV1oxVndPdGRLT1VkVmliSnFhNEJU?=
 =?utf-8?B?ZjNqQWJHdEl6UUJyUzUyMlhvU3VqVE94WHlMVlVNVDZpRDZpY2xzemdLNXBS?=
 =?utf-8?B?eWlEcndMZlFpTGEyVktKaDlrSmwrL3dudTVjcCsyR0FhemVTSmZOVm1BV2hi?=
 =?utf-8?B?bmVyVlhsMTUrbWdBYmpkcFEyRnNUeVNiL0pHMXZUSnMvZmtEaTJwTDdMaSsv?=
 =?utf-8?B?MWY5Q3ExNWxKMHNTUXpEVVQydlJzaXFpdXRJRWpQekFTWjNVQllhTFpjTjNL?=
 =?utf-8?B?SWZkYXRremx3bWFhQSszbWNPc2pJQ0lFOUZ1enZpeXJURlNHSDIrRUVXNFA5?=
 =?utf-8?B?azF1MnRqbzAzUzhCdWF3WkF1cGNhUnEyZlRBSkg5WHZTaENTM1NuZU5SQWJF?=
 =?utf-8?B?OXIzelJIZzBhc2pTbmVaYUE4T3RHekNjZzVZNldiUVliY2ozb3YxTEJZV3hB?=
 =?utf-8?B?R1RhR3FRL0YwSXF4ejlreVJKc0ptVE14dmIzd2tIdkVZN1VicnBSbXIzWEU1?=
 =?utf-8?B?VU96U252WDhBbGFqc1d6SDU2MHg5NzB0SnZEZmdoMnNhQXQyVUNmSFN6ajVp?=
 =?utf-8?B?VjkrdFY3WEN5ckg5SkJqVkVmc1pOSUdxL0lzSzR3RG50alVpWHFtVVhLTTNE?=
 =?utf-8?B?bUxoaHorYWJ1cGt2ZkU1VVExVEpCUkg3eE9RelVFS3d6U0pkd3FkbEdnaXFl?=
 =?utf-8?B?d2NkQXloNS9BaXJCYTlLVW5rSVhpeG81bGpQQXJTZkRTMmdSa1JMdGpyZDdH?=
 =?utf-8?B?bCsyUVZQdFNtU09qU3d6RkRNSUlJNlRaVnczNkZ6VWpXVUxHNEI4Y3dQNFpO?=
 =?utf-8?B?VnV1SGt2NHk0WU9qUU1teU1DSlBZWTluS3c4OVp4OERpRGJNOS96cFl3T3ZD?=
 =?utf-8?B?cGdLa05oN1NSNUhiMFlsNzMybGUrU3ZkakpnbTlBeVBZMStHNmw5aGFEbGpT?=
 =?utf-8?B?dUpldytLOUQ4RjZ4bmdkRXg5QUV4SCt5TG9BY0hsQk5WdnlyYlFzTGxTUVgw?=
 =?utf-8?B?WGZHUnZRRFhRTkVTZ1ovd25EZURNM0o5aDFhanZvTUpEcnJ4R3BnTkwyRDRD?=
 =?utf-8?B?NTAzcXBPdFFyTjdHbDlVVTRreGUwVC9ONkJlampoc3l6aldjamd5VGxBU3RU?=
 =?utf-8?B?VytLTjBMaCtGQzlHWDFNOU9mUy9hbjU2RHRtNXhGSll1YWd5bVRSUWtBa2FY?=
 =?utf-8?B?TGhNZDVyMzZwVk4wRmR5SGV6d3I2UHpLS0Q3NWNldFEwQkFYQ2lVd2hEcjFH?=
 =?utf-8?B?RzVVYUsvajJOOXRXbTRBUWpvY2U5a2dBcEI2YnlhZmdNSy90b2hub0RDd0Qz?=
 =?utf-8?B?SDl2MmxuYkpxc3h2cEE1NkJFZlRRelAzVHN5SWZMZGZOQnA2YmR1NGVNY3Z4?=
 =?utf-8?B?cE9NMnlsei9iamp6Yml1NEF4MnFwTEhXSkRpaW5uN3Rtc2xJMVNycGRiUFVj?=
 =?utf-8?B?b2FiRVNHaEVWcHlNeUNKZjBOVW1MT2lwMU9SZWNNT3RtVmtrL3AxeW1QSlJJ?=
 =?utf-8?B?SktxMGdyblRJTFBOa0J1eGNnUjR6ZDNYWW9YdHhzd0VPeENmOURaMmpYdmFv?=
 =?utf-8?B?UXJqZnFaN0h3SDhDU3dkNERTUkp0UkkvWTVxNXRHUzNNMGUvZmR4N1FHalRL?=
 =?utf-8?B?NTJQZUZTb213TkhjUTluazQvQ25zdUc3TjJHRGhVY2JuZXpycVp5anI5QmhW?=
 =?utf-8?B?MnJjaklvOXlodkhTc3NVTEFjUU1XWlJvZW9hTHNKYjBRLzAveGtWd1EzT2Jo?=
 =?utf-8?B?aEhwQ0RLOWRabG5WcnpJdFVrWEJJSnovWFB0aEtUQ1RpL1VLVFV2N09lZE4z?=
 =?utf-8?B?bFJ3Qm14VDBpUTNMdWcvbDlLSFVzdTB5cXJYQ05pUjNPSWR4R0dZSy9Fc29l?=
 =?utf-8?B?cVJPSGRKMmJSdCsyaERERXVhMkt1STU2Uzg0L2pYVDV4b2hGQVZ1dVpEdHZI?=
 =?utf-8?Q?f99auPLfvDVzIqL4P4hnhRExe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba3642a2-5c89-4d37-ad0e-08dc79be4959
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5874.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 17:48:56.3226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6p4gl8MQyhQKWlz2HMepWgTJ49J+h2jumTGTdCFATY/By8Bo0vNqzvvaybsnSKr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8220

Hello,

Ping for reviews.

Thanks,
Tanmay

On 5/3/24 9:15 AM, Tanmay Shah wrote:
> At least one IPI is used in TF-A for communication with PMC firmware.
> If this IPI needs to be used by other agents such as RPU then, IPI
> system interrupt can't be generated in mailbox driver. In such case
> TF-A generates SGI to mailbox driver for IPI notification.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> Signed-off-by: Saeed Nowshadi <saeed.nowshadi@amd.com>
> ---
>  drivers/mailbox/zynqmp-ipi-mailbox.c | 159 +++++++++++++++++++++++++--
>  1 file changed, 152 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
> index 1cb553cced90..7c90bac3de21 100644
> --- a/drivers/mailbox/zynqmp-ipi-mailbox.c
> +++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
> @@ -6,9 +6,11 @@
>   */
>  
>  #include <linux/arm-smccc.h>
> +#include <linux/cpuhotplug.h>
>  #include <linux/delay.h>
>  #include <linux/device.h>
>  #include <linux/interrupt.h>
> +#include <linux/irqdomain.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/mailbox_controller.h>
> @@ -16,6 +18,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_address.h>
> +#include <linux/of_irq.h>
>  #include <linux/platform_device.h>
>  
>  /* IPI agent ID any */
> @@ -59,6 +62,8 @@
>  #define DST_BIT_POS	9U
>  #define SRC_BITMASK	GENMASK(11, 8)
>  
> +#define MAX_SGI 16
> +
>  /**
>   * struct zynqmp_ipi_mchan - Description of a Xilinx ZynqMP IPI mailbox channel
>   * @is_opened: indicate if the IPI channel is opened
> @@ -111,6 +116,7 @@ struct zynqmp_ipi_mbox {
>   * @irq:                  IPI agent interrupt ID
>   * @method:               IPI SMC or HVC is going to be used
>   * @local_id:             local IPI agent ID
> + * @virq_sgi:             IRQ number mapped to SGI
>   * @num_mboxes:           number of mailboxes of this IPI agent
>   * @ipi_mboxes:           IPI mailboxes of this IPI agent
>   */
> @@ -119,10 +125,13 @@ struct zynqmp_ipi_pdata {
>  	int irq;
>  	unsigned int method;
>  	u32 local_id;
> +	int virq_sgi;
>  	int num_mboxes;
>  	struct zynqmp_ipi_mbox ipi_mboxes[] __counted_by(num_mboxes);
>  };
>  
> +static DEFINE_PER_CPU(struct zynqmp_ipi_pdata *, per_cpu_pdata);
> +
>  static struct device_driver zynqmp_ipi_mbox_driver = {
>  	.owner = THIS_MODULE,
>  	.name = "zynqmp-ipi-mbox",
> @@ -189,6 +198,14 @@ static irqreturn_t zynqmp_ipi_interrupt(int irq, void *data)
>  	return status;
>  }
>  
> +static irqreturn_t zynqmp_sgi_interrupt(int irq, void *data)
> +{
> +	struct zynqmp_ipi_pdata **pdata_ptr = data;
> +	struct zynqmp_ipi_pdata *pdata = *pdata_ptr;
> +
> +	return zynqmp_ipi_interrupt(irq, pdata);
> +}
> +
>  /**
>   * zynqmp_ipi_peek_data - Peek to see if there are any rx messages.
>   *
> @@ -748,6 +765,112 @@ static int versal_ipi_setup(struct zynqmp_ipi_mbox *ipi_mbox,
>  	return 0;
>  }
>  
> +static int xlnx_mbox_cpuhp_start(unsigned int cpu)
> +{
> +	struct zynqmp_ipi_pdata *pdata;
> +
> +	pdata = get_cpu_var(per_cpu_pdata);
> +	put_cpu_var(per_cpu_pdata);
> +	enable_percpu_irq(pdata->virq_sgi, IRQ_TYPE_NONE);
> +
> +	return 0;
> +}
> +
> +static int xlnx_mbox_cpuhp_down(unsigned int cpu)
> +{
> +	struct zynqmp_ipi_pdata *pdata;
> +
> +	pdata = get_cpu_var(per_cpu_pdata);
> +	put_cpu_var(per_cpu_pdata);
> +	disable_percpu_irq(pdata->virq_sgi);
> +
> +	return 0;
> +}
> +
> +static void xlnx_disable_percpu_irq(void *data)
> +{
> +	struct zynqmp_ipi_pdata *pdata;
> +
> +	pdata = *this_cpu_ptr(&per_cpu_pdata);
> +
> +	disable_percpu_irq(pdata->virq_sgi);
> +}
> +
> +static int xlnx_mbox_init_sgi(struct platform_device *pdev,
> +			      int sgi_num,
> +			      struct zynqmp_ipi_pdata *pdata)
> +{
> +	int ret = 0;
> +	int cpu;
> +
> +	/*
> +	 * IRQ related structures are used for the following:
> +	 * for each SGI interrupt ensure its mapped by GIC IRQ domain
> +	 * and that each corresponding linux IRQ for the HW IRQ has
> +	 * a handler for when receiving an interrupt from the remote
> +	 * processor.
> +	 */
> +	struct irq_domain *domain;
> +	struct irq_fwspec sgi_fwspec;
> +	struct device_node *interrupt_parent = NULL;
> +	struct device *dev = &pdev->dev;
> +
> +	/* Find GIC controller to map SGIs. */
> +	interrupt_parent = of_irq_find_parent(dev->of_node);
> +	if (!interrupt_parent) {
> +		dev_err(&pdev->dev, "Failed to find property for Interrupt parent\n");
> +		return -EINVAL;
> +	}
> +
> +	/* Each SGI needs to be associated with GIC's IRQ domain. */
> +	domain = irq_find_host(interrupt_parent);
> +	of_node_put(interrupt_parent);
> +
> +	/* Each mapping needs GIC domain when finding IRQ mapping. */
> +	sgi_fwspec.fwnode = domain->fwnode;
> +
> +	/*
> +	 * When irq domain looks at mapping each arg is as follows:
> +	 * 3 args for: interrupt type (SGI), interrupt # (set later), type
> +	 */
> +	sgi_fwspec.param_count = 1;
> +
> +	/* Set SGI's hwirq */
> +	sgi_fwspec.param[0] = sgi_num;
> +	pdata->virq_sgi = irq_create_fwspec_mapping(&sgi_fwspec);
> +
> +	for_each_possible_cpu(cpu)
> +		per_cpu(per_cpu_pdata, cpu) = pdata;
> +
> +	ret = request_percpu_irq(pdata->virq_sgi, zynqmp_sgi_interrupt, pdev->name,
> +				 &per_cpu_pdata);
> +	WARN_ON(ret);
> +	if (ret) {
> +		irq_dispose_mapping(pdata->virq_sgi);
> +		return ret;
> +	}
> +
> +	irq_to_desc(pdata->virq_sgi);
> +	irq_set_status_flags(pdata->virq_sgi, IRQ_PER_CPU);
> +
> +	/* Setup function for the CPU hot-plug cases */
> +	cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "mailbox/sgi:starting",
> +			  xlnx_mbox_cpuhp_start, xlnx_mbox_cpuhp_down);
> +
> +	return ret;
> +}
> +
> +static void xlnx_mbox_cleanup_sgi(struct zynqmp_ipi_pdata *pdata)
> +{
> +	cpuhp_remove_state(CPUHP_AP_ONLINE_DYN);
> +
> +	on_each_cpu(xlnx_disable_percpu_irq, NULL, 1);
> +
> +	irq_clear_status_flags(pdata->virq_sgi, IRQ_PER_CPU);
> +	free_percpu_irq(pdata->virq_sgi, &per_cpu_pdata);
> +	irq_dispose_mapping(pdata->virq_sgi);
> +}
> +
>  /**
>   * zynqmp_ipi_free_mboxes - Free IPI mailboxes devices
>   *
> @@ -758,6 +881,9 @@ static void zynqmp_ipi_free_mboxes(struct zynqmp_ipi_pdata *pdata)
>  	struct zynqmp_ipi_mbox *ipi_mbox;
>  	int i;
>  
> +	if (pdata->irq < MAX_SGI)
> +		xlnx_mbox_cleanup_sgi(pdata);
> +
>  	i = pdata->num_mboxes;
>  	for (; i >= 0; i--) {
>  		ipi_mbox = &pdata->ipi_mboxes[i];
> @@ -773,7 +899,8 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct device_node *nc, *np = pdev->dev.of_node;
> -	struct zynqmp_ipi_pdata *pdata;
> +	struct zynqmp_ipi_pdata __percpu *pdata;
> +	struct of_phandle_args out_irq;
>  	struct zynqmp_ipi_mbox *mbox;
>  	int num_mboxes, ret = -EINVAL;
>  	setup_ipi_fn ipi_fn;
> @@ -821,14 +948,32 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
>  		mbox++;
>  	}
>  
> -	/* IPI IRQ */
> -	ret = platform_get_irq(pdev, 0);
> -	if (ret < 0)
> +	ret = of_irq_parse_one(dev_of_node(dev), 0, &out_irq);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to parse interrupts\n");
>  		goto free_mbox_dev;
> +	}
> +	ret = out_irq.args[1];
> +
> +	/*
> +	 * If Interrupt number is in SGI range, then request SGI else request
> +	 * IPI system IRQ.
> +	 */
> +	if (ret < MAX_SGI) {
> +		pdata->irq = ret;
> +		ret = xlnx_mbox_init_sgi(pdev, pdata->irq, pdata);
> +		if (ret)
> +			goto free_mbox_dev;
> +	} else {
> +		ret = platform_get_irq(pdev, 0);
> +		if (ret < 0)
> +			goto free_mbox_dev;
> +
> +		pdata->irq = ret;
> +		ret = devm_request_irq(dev, pdata->irq, zynqmp_ipi_interrupt,
> +				       IRQF_SHARED, dev_name(dev), pdata);
> +	}
>  
> -	pdata->irq = ret;
> -	ret = devm_request_irq(dev, pdata->irq, zynqmp_ipi_interrupt,
> -			       IRQF_SHARED, dev_name(dev), pdata);
>  	if (ret) {
>  		dev_err(dev, "IRQ %d is not requested successfully.\n",
>  			pdata->irq);
> 
> base-commit: 9221b2819b8a4196eecf5476d66201be60fbcf29


