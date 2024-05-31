Return-Path: <linux-kernel+bounces-197372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B07A18D69D0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 21:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC6941C21F78
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 19:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC67158D9E;
	Fri, 31 May 2024 19:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5BoA1iZO"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2059.outbound.protection.outlook.com [40.107.102.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9CE1C6BD
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 19:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717184085; cv=fail; b=ZGjXHafLeN+u3qGwXfP5oFPdBDpoN6wMNpsytvIJl21fKQ6R9CMFX/nsKDIbyFHyb043A8XbGDP7wmItrUCYby30BYJ217/zw627trbBKf+sRf3DWW38+tv6ozfUGSvwfoEIaZK5y33j9aAEqG54V+4IhSU+ho9bpcIfVvyL2AA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717184085; c=relaxed/simple;
	bh=i2EW06MJStlnJqnIXVMIYfhy3tAG+0aYRhtwbml8oXk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ayn36pxycRocwAGoic+Q4LxOJL+sHEZoa5JfCaRI8YIrLI1WZ5wOB8429CkdIfaL+FCMmpPQyJ/pzAPI78guAgEOuXdLKSFA4A+OINvFGUlIc58g5sOxh+85XZloUPlDpIbDfcZydXLbihLU0daYCqwAOdBjvosCTGsmZB6fEVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5BoA1iZO; arc=fail smtp.client-ip=40.107.102.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4ckGPOC6+D6pRoo86eus9TdK8W5lOZXaxLOKctVBeMz1RN5ci2niPMmMlCYFZ4Wx1ph68nCO00kR5s6kj4cs8TaFBCb8fCfQSjmbicQn0MCAAPFB1zlq9pTerqE6U7oCage7BHe4oZPd9diCSSzO142lkSlcGgEM7RQX0kQW5VvGWqZOLqp/QNTx1hLyKCcpUSOYgNH6jFDp5ubnmV5cotZrmi+Ee2MGMzcApbZTdUkojwDzbSdwqvG/lo7lwKGj0alglPdW6zn0ZOOBpIF2P6wIC6ki6E17ZEiSbiHW6G8oCEVEX+ochscS3AA55Clry/ru3C4QtGrWn0W6Pd/0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=44uxD4DTYdNfz5YYpfGvNQz94eD3MqNESInykVFneA0=;
 b=cKw/WUtSdTb+M/U0+lih1ZR9OTf8UskEuRFhGTm1JCSlYpwvH+P69vo5O0NJzD9x3mgezDPQVJRJbLl8yohnJ/S1RDTxmRQ+ilujuLhMf27XjUQCil+E0WFK3dVUUiQ+HXLWHg194efhJR0iyNYVPwBjC7KIgNbRMDUH/bMNML/I8lSK4rskxOLOdNSn5Jxv+CwoqYAkWLoRqBDbmzBA82A2xJzVt6eB64BS5SZT1IDAo92g3zgduv7RLm/gx3DCKA9Vntvob/5JKLwCbQfHkb1p3aZ+CW8pHqDvKWa9FINmx6OYQyKgQAZrkYmIY68LkA9av9C2jmVd71CvwYIu3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=44uxD4DTYdNfz5YYpfGvNQz94eD3MqNESInykVFneA0=;
 b=5BoA1iZOyAGyIBhNcQ0O4soTvUeLBzIoELwEYeowPXEFMwG++syLR9UGwaTl1sYH+iFCo30GDnqaHcP0uOyxF+1FKyXQw6wC3V3/qJ/mQo+5U96jKmszw4u0ueSpPDsomfusMfpmElk4np5X/Y+zELPws9pEHcu/XQQmIka5HTA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by MN2PR12MB4095.namprd12.prod.outlook.com (2603:10b6:208:1d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 19:34:39 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 19:34:39 +0000
Message-ID: <d97f837e-fe7c-64ed-78ec-2581607150c6@amd.com>
Date: Fri, 31 May 2024 14:34:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 10/15] virt: sev-guest: Choose the VMPCK key based on
 executing VMPL
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, linux-coco@lists.linux.dev,
 svsm-devel@coconut-svsm.dev, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Dan Williams <dan.j.williams@intel.com>, Michael Roth
 <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1713974291.git.thomas.lendacky@amd.com>
 <b8508f57712e3194484aa8695494eea26abe1b73.1713974291.git.thomas.lendacky@amd.com>
 <20240531125503.GEZlnIp7YobFu7g9iS@fat_crate.local>
 <ad55da28-e5e0-a348-3cbc-d1a80d0ab2bb@amd.com>
 <20240531190348.GKZlofFDL4ESfpOQ6O@fat_crate.local>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <20240531190348.GKZlofFDL4ESfpOQ6O@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DS7PR03CA0327.namprd03.prod.outlook.com
 (2603:10b6:8:2b::35) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|MN2PR12MB4095:EE_
X-MS-Office365-Filtering-Correlation-Id: c36712bc-f5f9-4951-8eb3-08dc81a8b60f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015|7416005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?azFVN0M2OGtzNWtQbnBmVW5hYi84alJpYzB6dmRONmVIakdhZkt1WlZLdUE4?=
 =?utf-8?B?UWJhSStjYllvVkE4OVZSR0htcFJJdTAxdGdCc3M5VE1WZHN2dWp0S1NXR2Ns?=
 =?utf-8?B?MHJ5VmgyWDd5eHZMQmhwMTcweFMvNjlrMzljVlFlVWNIQTZHL21zSFM0NTRk?=
 =?utf-8?B?RUhUamxta2dVTkNZa0tTOTIxRE96SFNRbE1mcUNCQmR0MHR0emEzeXpRQ2Zm?=
 =?utf-8?B?NWZIenE0dE1JaGlNMjYvaUVKdFQ4Wkl2bkVmbjdBWHN5WDVDU1hXR3Zxelll?=
 =?utf-8?B?cStPSjU0Wmo1U1I2d1VMOVM0WXRrcTBLSFZPYlhDUGRIM2Z1TjRhbzZ4alpP?=
 =?utf-8?B?Ly9uL2V1cUFOaWxyaUpVK3ZBMTh2eTF4MjlRbmNESlhMUWUrZGtVdGcybnB0?=
 =?utf-8?B?VUJTSlNaZ09vV3U4SXRnb2pJY2dLbEg0UFhPTHRpVzJzeE13S1U1dUtVcDZR?=
 =?utf-8?B?dC8zdlg0SWExQjJsVVh3OFN5eThSVTFZaDJRejBKVFJaUC84Rm9GWVZ0QnVk?=
 =?utf-8?B?aUdwdzBWeG9xTEdWSlEyb1Joai9DeGFsek5ycng5cjFrRW1VZTRnWFBUMDZo?=
 =?utf-8?B?cHIyL3M1eGhJQWR5Z0hrTHVObHV4cmcrZFdJcG5VZE8xNWtBQzNieFlVYkJl?=
 =?utf-8?B?ck43RGhwa1kzTnN6WG9ySU1UVUNJY0d4TkJtMUZqTlU3bHBObjNKeHI0ZCti?=
 =?utf-8?B?OWpmNE5mRys5OXhUblBydHNsMGVKTGFUaWpmNXlDQXlvZWlCaUMvVmgxY29S?=
 =?utf-8?B?c3hyNjRzd0FOMFphTkl6bmlIeStXU293Nk5zUVRYNjBEbkF4c2F5RGRpYzRE?=
 =?utf-8?B?cEt6d0Z2NjJxcGRoSjFNSFdpWENrNmtwZnpGZ2dEVFNSR040RU4zTmFLYUJR?=
 =?utf-8?B?UExwdE1EWUpZSnAydEs5YW9KdzVvdk5WUWpjL3hTTE1EUCtjTjNJdVdSZDJ0?=
 =?utf-8?B?QlVNWEY2MUV1bXR4V1ZudVBGVFpCOG96VUx4RXdIZnRhbFFqczlVN3pTR1Bk?=
 =?utf-8?B?bUE4eWIwa1BpdzlpNXlkWUJDY3FNZk1QLzJCdVVTOEZrL0huQXZTTWx6Q2li?=
 =?utf-8?B?eC9aMnNVR0lmeTdUNytGUWJmM1FyTTRxWnBMTXoxTHNrTFFwdGJwWlQyMXc3?=
 =?utf-8?B?TXFrOEZhTllMVzNCK0F2V3I1eHRhbDd3cmdXckZwNzlkOC9pcXUyY3dCSVBQ?=
 =?utf-8?B?OWtxeEdLUjIzQ1BzNXJNYTlmRmlPQlY0a3p1d3dPdGRVODNuK05oVC9LMWhV?=
 =?utf-8?B?RmdtZnlDb0RJbnc4YVlPMVpKVjNmemgzbTIyVC95WVE3VVpCNjJpWTFFZDJj?=
 =?utf-8?B?NndsRHkzRjR4SVBkT0ZJK2V0NWNLczFsOHRkc0NOdGxpWUVwMlZiS1Facmsw?=
 =?utf-8?B?VFcvd3FxNkwvRXFwZkhJS2h1K3RGZUNnOStXT1FhZU9ZeWVQT1d0am91Tm9C?=
 =?utf-8?B?WXQ3MHFSOHNBNnR6N1VBUXpYYm1CS29ZdW1RcVQ4SlZKMmVDQnh4ajR0S3RQ?=
 =?utf-8?B?SGVVeFBVU2hjRlFnVjZGRzU0MldybkY3Wi9maVptdEh6RzdSYUluSjBhSnRm?=
 =?utf-8?B?a1YwQ3pPOWQ4eWNnci9POEhSUElIZzRLRXgxY0RPYUJCZUZRWExOOHh4S3ln?=
 =?utf-8?B?WGpialM0Rys2Ymw5cjNiQjRvMys0QzNpeVFscnBJYjh1Rm83M3ExV3g1MURK?=
 =?utf-8?B?R3JmOTluazVnZUFPTDJLcG00MzRtZkM2WGh2UkoySjk4OG5OdkQ3cWVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0FHN0pmM3RoOEIvNmdQOEI2MmVBbkZGWXUzQ2RCM3M0M1NIWTRlVWF0TVlU?=
 =?utf-8?B?N0ZOZGpxOHZUOU5EYTlHRGZJaHYyMWZxSStWOW83MHc2UTd5TUNIcFRMcXpL?=
 =?utf-8?B?aEFCTUFmK3VnY1VQZDA1SnhOTjcwd0dGaFlHdDZNcHNxanBPUlBBR01FMGR5?=
 =?utf-8?B?U2ZqNnFTYzRWaTQwK2RMVXNBWjQ1OUI5RHdDUG05aTVZbHVab3JEYnBwNVVu?=
 =?utf-8?B?WDMyKzBmSGVpUFBqWEhiTml1NHZIMzEvWEhVOU40ZFJQaGJZNXkzYjQwK2V6?=
 =?utf-8?B?ZXRxUkV4T3JMay9oZzNOeWhURHQrK1Y0SzY0RFkrQkR3VG9JUU9Ec2FtaEp5?=
 =?utf-8?B?RG5YZXl0RkdOQXRPdURUL01WRWtmbXd2dUROS01SZHFqTGZsL200dytiWldj?=
 =?utf-8?B?cXF5SndYcTNsUFBwY3BhQmRhWVhKdlAxQytnZHBSNEpwQ2h2UmRUTVBQVCtu?=
 =?utf-8?B?Zzc0U1UzTElFOHVXY2NDbkhlNXp3VHNmMSttRUtmUWQ2MStPS0pvMXhTak54?=
 =?utf-8?B?ajBpSE5JdUptb0p1c2luZGI2Q0hEMzJVRzQyY2JyUWkvYkNFVTlzK1MwRy9K?=
 =?utf-8?B?ck9aUnpLaFBOSzc3aHFuSXJYSllCaEZoWFQ0SWl0MVU2MDhlbWNqQzFPNzJI?=
 =?utf-8?B?TUFXU05HK1VHSFFjbXRqSXZ3a0I4WEJ6OEtXeGx5SUoxd2tYVCs4NmdsUGs1?=
 =?utf-8?B?dUtYZlN2UkdUOWZtVHRVcEFaWm5nbTVYRzVscGxvcU91TUp3SmVUZ282aDQ3?=
 =?utf-8?B?cGJBV01weUtnQUszN3BiSnkwNm96dWp0NjR0MGdZeWNGYmRpYnBuODZpUW5m?=
 =?utf-8?B?b3Z3TFBITEJROUl2NWVWcVQ2NXhYSWYxOUNaZVlwRUxYWitPWXJVV09jdVlP?=
 =?utf-8?B?NnNuaU9CV3JzRUZGbW9MOEFraWNlNGFFc0RzWU4yQnpsNzVseFJza0pLdmRW?=
 =?utf-8?B?Y0hxcFJ2SFNUK2dVM0RYNHdpVDZ1LzJIcVZmOWVBUm5CckdQRk1XTUxOY0FD?=
 =?utf-8?B?NGJLblVwWFZnNkJ6cXVzY0NPdkpOdjI2aW5MemJPRXo4NlJQakF2VHY0TjJ5?=
 =?utf-8?B?bVVZcU9mUTN6d01ZSHJGWXg3T3hXSGJnbWlWRHhsbFZueW1nZ1FZMlh3RnAw?=
 =?utf-8?B?MTRSSzA2dTQ4OTlhZzIvRUdlcjdqSFNZZS9OVU1ETmhQTUtJbDk5LzVrMjJM?=
 =?utf-8?B?Um9ncW92V1ZPZmpHQ0N5OXNzdEdYTXFsQ2pDQUpPa3hDRXF6Sk9OTjVBNjJ3?=
 =?utf-8?B?Ykx1emFOOWtwajN2UVpPYkgyc1poZ2ZpMEhxc0pZMWdSNWdlR1d3M3NISis4?=
 =?utf-8?B?N2wxMzVyR2kyREh3Y2ZSYWNTSXRKalh5OFp6dTlCKzQycEJNTDJyaG50RExT?=
 =?utf-8?B?aEdQRC9MRW5vdzJ4NWxza211dnBsdTlrNUxNMmdwdzU0ZVU5MnZZRllHT2t5?=
 =?utf-8?B?YURWWTZTaGJZQTlKbUhzWjJjYndBdHhJeWVWZE5PSDFKaktNaCtWSDYvK2VY?=
 =?utf-8?B?ditMdnNqRUlwNkZMUm9BYTFuVmE4VURwVWJLSDFOMy9USmx3b2pVdEUyMEY3?=
 =?utf-8?B?eGdnTitPeDI2VVVUbzR4ZVExZUpieTloUlQ5dCsyTGFUdXRTeUplNENJdFlt?=
 =?utf-8?B?cGdDY1RWUkpnSFJMMVdzY28zbmhlQnQ1cGl5UjB3SXRwdkgwUS91TlhLQm5E?=
 =?utf-8?B?TUpEemJQMGYyTVJ4UVB6SFRoZG80QjJXRkFpVVFEUkJNY04waVplbm8vNjg0?=
 =?utf-8?B?dEZSZWZ0REJRTXM0bGhxNU1CNHhZT24yZVpPN1JrL1F2WmgrYW5YK2REYnRv?=
 =?utf-8?B?Q2ZBUk9Qa2pzVWpES05EV2FKM3VaVzRMcVl2OWJCNE9Zc3BKbGlyTWloVGNX?=
 =?utf-8?B?bS9ZcjR3QTZudWUrdmxSYTI1WnZTWTJLNzI3LzdqckQwVnY4STFoQ0w1M1hU?=
 =?utf-8?B?TWZtK3ZzRFB5NC8wb3psRmVuK1RMZEt3ZGZHdHREaDNvejhkVGxUbjF6Z1pN?=
 =?utf-8?B?L1RtMDBvZkRmbnkvaGpJdjRsUDdsWXd6U3Rsd2pYNWFzMlN0cFVacEg2VXpW?=
 =?utf-8?B?N1doUzlKcjI0bTMwZWlLUEpnR2c5RGNseUJKVmRXOHNQakl3em1xeVFwdUFq?=
 =?utf-8?Q?CyjTiTBH6jmZoFApLL8dWOEfT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36712bc-f5f9-4951-8eb3-08dc81a8b60f
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2024 19:34:39.0302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sLY3zkQpsYXuRg/UvRvKSYfX12fv0uxrvZzETKQUEs8CYRIGg3c9RPAwjMQUtgLVvMotBA88r6lofDs49+oakQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4095

On 5/31/24 14:03, Borislav Petkov wrote:
> On Fri, May 31, 2024 at 01:36:06PM -0500, Tom Lendacky wrote:
>> The sev-guest driver needs to access it. Given it is a driver/module, I
>> created the accessor rather than mark the variable EXPORT_SYMBOL_GPL(). Your
>> call, I'm fine with either.
> 
> Yeah, if the variable doesn't change after init, then you don't really
> need an accessor.
> 
>> Yes, the driver can and does figure it out. However, this module parameter
>> was added in the off chance the default VMPCK gets wiped. Then you can
>> reload the driver and use a different (less privileged) VMPCK.
> 
> Is that what the text over snp_disable_vmpck() is alluding to?

Yes, I believe so.

> 
> Or where are we documenting this intended use?

It probably should have been documented above the module parameter itself 
and/or in the sev-guest documentation. Those can be done as part of this 
patch or separate, whichever is preferred.

Thanks,
Tom

> 
> Thx.
> 

