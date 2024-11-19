Return-Path: <linux-kernel+bounces-414669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B649D2BD6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 17:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A5FE28820A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 16:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26EA153598;
	Tue, 19 Nov 2024 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GPdGBrP7"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2056.outbound.protection.outlook.com [40.107.101.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 624461D2239;
	Tue, 19 Nov 2024 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732035065; cv=fail; b=UC8deapeWUf3oPqOavjpjZpjGWmoh7Vi7Wo19uGHkhza7R0mBJ33s/EJcwgX7khKnI5xJfZTEGeD2XJ6/VIH4KH0PzOpWH7m1NeQ/6zN8cnlRJvPCwd3npN156Mgy2poWlw2LgFo4Ho8MGVPvLS60u/fNYNIb4JA2EPZIw3J0lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732035065; c=relaxed/simple;
	bh=M3y9AKP+5ZJtmdSPDAh05nBlKb2MFNVciNUcs4QV9vE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D2Mtoqm6v7Yj4kD3T1MMXV+HzB6+Y8PGv6KlMSw2MiN/Yc+6lbBVtGAYtxFinSWPfRu88k0fbVly/HTncY8HT0LPQXqQ+73w34OSB0w3dp2Q6TnjYSNJVx8CEnoIX7KM6mZu4Imofx0r5U9cP/o7EbvmN4VmGa4dAkCDR6RTVS8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GPdGBrP7; arc=fail smtp.client-ip=40.107.101.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sBCpEzFg9WlyHN+7UObY1smGgZuJYwkeuZW1XWiaMnIVoYZVvbpJOpAZ1aGoKD88InS6rk2zgMKlXwNvri7ZOAv+IoPpKgqIXUA+XqrecBBMXI0X5wiqdX12gE5+oJE+U0gxqMJMr9+EZSh3h3OtKvHv3NrDfkGFOJBoavO/2Tnqa5Vgta017YADc6sYG/5YufvxE5wSSWOWXN3dLQGQ0hdlUMUA039Q53JiKAHoksd3AorvJsNKQaT6XiUOpANCQhIjVhOyiD/c3yGkXzc31J56AQ12X1EA8DLoFpyjGU67ZrdMc1sB+Etw4FZzS8GNQLVTd7KvH34jJKXvvfrW5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OTZAKZM5WmENqxGNDxsI6H9vr8K1KR5r5nnBNWO+yRc=;
 b=bJ80E0SV+cZOmbp1+tAQxhMljx9eS6/7rZEZRcQDLEYfT6H3fYlqJtKHwiLxUMXdy4P1YQldA4aQ4ndtiIpPVBKNQ+OZclIB0fwzhNydBnITx4XOQNDMMxoHQBsz21tkrOQLELGJwP7Wd1/Ad5Cu8gCaEuH3Y7lW+xQhw3NAb3ywKjJ8hfM5LV5xew2mu/wpG0sfzNQEzWUupd8eoFOtJYMqJdkQt7itH8mhtZ5oq66YOU4THyYWJihnUVhQhBSbkULbOPLS2hiiJtOeK7IzVUg3UDfYrwZwIXV61YPDCtfv1Jj4d52dWdaoVkklOuXsh0WWRiAm8SGdPMuFSUxZAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OTZAKZM5WmENqxGNDxsI6H9vr8K1KR5r5nnBNWO+yRc=;
 b=GPdGBrP7PP6bIu6aK2l4JX9ZDM42IYMz4PKCLi+nmSkgNAYk+UD7bZSspr/23RLVCGS9ClrgvoYw84CzfyAOFzGAerWf2MJAYhhr/CNmLsyPpDYZi0ha+9+VJYbP6G49aGWioScAlnY8o4GLh6XKR75bvYyR8ydmidy755/LYLg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by PH7PR12MB5903.namprd12.prod.outlook.com (2603:10b6:510:1d7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Tue, 19 Nov
 2024 16:51:00 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::b0ef:2936:fec1:3a87%4]) with mapi id 15.20.8158.023; Tue, 19 Nov 2024
 16:51:00 +0000
Message-ID: <2ff9a99a-5fc6-4f93-a760-5480283cd8b5@amd.com>
Date: Tue, 19 Nov 2024 10:50:55 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v9 12/26] x86/resctrl: Remove MSR reading of event
 configuration value
To: Reinette Chatre <reinette.chatre@intel.com>, corbet@lwn.net,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: fenghua.yu@intel.com, x86@kernel.org, hpa@zytor.com, thuth@redhat.com,
 paulmck@kernel.org, rostedt@goodmis.org, akpm@linux-foundation.org,
 xiongwei.song@windriver.com, pawan.kumar.gupta@linux.intel.com,
 daniel.sneddon@linux.intel.com, perry.yuan@amd.com, sandipan.das@amd.com,
 kai.huang@intel.com, xiaoyao.li@intel.com, seanjc@google.com,
 jithu.joseph@intel.com, brijesh.singh@amd.com, xin3.li@intel.com,
 ebiggers@google.com, andrew.cooper3@citrix.com, mario.limonciello@amd.com,
 james.morse@arm.com, tan.shaopeng@fujitsu.com, tony.luck@intel.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 peternewman@google.com, maciej.wieczor-retman@intel.com, eranian@google.com,
 jpoimboe@kernel.org, thomas.lendacky@amd.com
References: <cover.1730244116.git.babu.moger@amd.com>
 <3180058bd0b5f80f8525063698c6d5971165193a.1730244116.git.babu.moger@amd.com>
 <f653969d-b946-43df-a5ee-d5153589bc5c@intel.com>
Content-Language: en-US
From: "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <f653969d-b946-43df-a5ee-d5153589bc5c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1PR05CA0018.namprd05.prod.outlook.com
 (2603:10b6:806:2d2::18) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|PH7PR12MB5903:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bd11cea-241d-4da2-4c44-08dd08ba589a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dFExNUZzbS9IY04xUDVsVEtBVXEzWFlNL01Na1VRV2dBRkVNZkZUdG1maFR3?=
 =?utf-8?B?cjliR1FLL1J4MW5TU3pSSTBkQnppZmxSU0VzMXNMYU5pWUFZZVFyVE9uTUY3?=
 =?utf-8?B?cituNDh4VllONmZPUHlKRHMraGhRbk1SSzAzb0R6Z05qMmpsQUdaWGlCUEUr?=
 =?utf-8?B?aUpsdEV4cytTT2Z4bThxMDh4ZEdpSS9qazgyUG1vbDEzWlVxRHhUQjlEOHBP?=
 =?utf-8?B?aGJtaURmSlNqOEtXM2xrSHJqdStIWDZaRitYT3pHRHpCbWd6V2RxZXdXN21r?=
 =?utf-8?B?R1YvMDBlSCtES3ZhYjQyN3djYVU3NUFJWDN4NzhYOTNzU2VTcUliME9vbWV1?=
 =?utf-8?B?MWEwdXUwRVFSbDN3L2RUWGdJcS9YdmRmVTAyQWZucStadUhLZW9yRWxMMW4z?=
 =?utf-8?B?VjNCZVlGUkw4MDIwWFZlSXQ1TUg5aWJudUFmQm84YnpqYjlRMDhiYkFzQlFo?=
 =?utf-8?B?a282bitGWmpiOFVOUG1MSEcwS3pwMWg0Qy9jbnFjZitnbTBJZGo1R2xGUEhz?=
 =?utf-8?B?a1dpQW1MSEpCQ2p6S1F1WXgzVGl1c3dscllOMWtSTVRaOHdXR01zZDR1NUtP?=
 =?utf-8?B?aElBb0tlekR1V0orVUZ5OGFzSnRJZHptRXhKSXlBMTRXSlM4Ty92RGFxV0h4?=
 =?utf-8?B?K0s2cldKbzZBYXQ4MDNrSzVoZXJTb0F5NUFkZkE4ZnJDTVJoVjJuZUNyUnpO?=
 =?utf-8?B?djVhajk5U1JMZjlJekRTNUhkSlloeTI2Vm80aStpbnB6R21lcDYrOTJhUWpq?=
 =?utf-8?B?RVpuajFXOGZMUU12elpDWVVxVU5BYWg5OXlPTlM4ZVpTLytWZGdFcjZvT1c4?=
 =?utf-8?B?Z05uTDAxN2grQnk3MWlDcU5FSkovcDBMZU9UOXJaTXpMRVB0S0I4MHcyS2lo?=
 =?utf-8?B?bUVEVXN4UHdYblhURVRsdkY2VHZuTERrMFJVQmZIaFYxWGo3c3ZEREdtbjUr?=
 =?utf-8?B?dUxKRnZhbTNMcWlxRUFaREt1NVpqQllEcmE2aWc5SUZ2dE9xVjZTdStwMC96?=
 =?utf-8?B?ckdscktWSEdJa2VEc2lWZHFYc1NObmVRQnljYjlXczRFWnN5L3Zib2d1c0JT?=
 =?utf-8?B?b2tXa0JwOVY4ODBLZDBpRHRTZWNreHNGZEg3WUs4ZW1MQ2ZQVE5SSW5TdWlq?=
 =?utf-8?B?TDcrMU1rM3poMmtGNHdzdG9pclVhYmZXeFVPUmhxMlBtcjY3dVJraXR3VDYw?=
 =?utf-8?B?NUVKSlN2aEh5cTZVREVjUmdPNjZNWEhsRUZvSzZVMjlVaWh3Vno5ZGREbVRY?=
 =?utf-8?B?OW14MDNBMklYZ2dOeUhEOWlqZjlqLzk5cXkvVlVmakNZekxjM005YWdyNURx?=
 =?utf-8?B?KzlWSWdiR3pZWHVhemloSG9QS0FRRTV2U05Fb3QrN3o0eHZQV3E2L25pMFF2?=
 =?utf-8?B?djhBWkZyblBoN2NzdGdEQloyUVliZkxVblhQM2NkU0JqU0IrR3ZKQ1hNZ0ta?=
 =?utf-8?B?dUUwZi80dTRFb21SVzhrbTM2U0VSbWhZOW0zWjZ6UmZOVFBkSWpreVEwOXYz?=
 =?utf-8?B?cmVuUjBrWHQ5WFpZc3JtUTNoaXB3OTQwZlRtSzZzT0ZmSExOSWYyU0MxcERt?=
 =?utf-8?B?WHV6dlZSQ1pCM20yQXJLamlKVUpjQzFWZVQwVVJzNloxQVZIdWlKVzFMYXJM?=
 =?utf-8?B?SllVRzM0UlZKVnFsRUxWSll1OG5WeXM3Y2FzNmk1RkpEcEEvbmZXeitBODVU?=
 =?utf-8?B?eWFjRFovaENFd2MxcG43VytDdkVvc3BpZjVxZGJGYmd5YksxMG9EQXAwRlZG?=
 =?utf-8?Q?XVBpl2nOMNTGMEp2rwoaWSzyhdM2A7qgZpmo0+A?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWJ0emVqQzNIY1plakhFSHdrYmN2R3ZhVSswSmNLSXRjOUJmR3Jodm4vc3pE?=
 =?utf-8?B?QW85Y2JsRHFaTXhNcUZhZW94cGU2cXM1Z0cvRWZ4STBJT09FRjZlb0tKVy92?=
 =?utf-8?B?NGUxdlpzUXlYYVQza1lHUE1abk8xUzRiaGIrY2M4YVF2V1d0N0dCYXdqNXFN?=
 =?utf-8?B?djVwalBIKzBacVlseHhJbGpZeWRmMElHQmdEMkRwbS9XZjI0dHh1OUh3cFVO?=
 =?utf-8?B?bWxaVGxGS0xkdVhFRTJUK1BoK3RWS1dKdXlrc2J2Tk9OZ2RoRXJIMjFDaU9S?=
 =?utf-8?B?Ymsyb0VFY0FMcUZXQmhlcDlWa3BXcnBac2hxZHhqOHdNV1ZrcWVrcGJVaVBO?=
 =?utf-8?B?b1g4aFNhSnlXczFNRlBydHlHT0gyU0p0TlA3UDA0OFFKbjFsU1AwdW41QXAx?=
 =?utf-8?B?TGNkaUgwOGJWUFV0T0YycGVFaWsxRkpnV2EvUEtvREVIeVVaZnZyZ2JpdGRU?=
 =?utf-8?B?aThOQTRwdzl3R1VwcGNKaHRXcGZybWxFSXA1bTNKckVrWk9ZYlhFZDFKc3Zr?=
 =?utf-8?B?ZGk1UEUvb0QvcnFNL1F5SnNYLzhWTkppSUJwMk8zM2dPYTM1d3MrVStvUDVU?=
 =?utf-8?B?WUhhTjFEZ2NNekQ1VkJoSXlBOG9pOE5QelJpVlJjOFhyLy80ckNXOUE4RXhO?=
 =?utf-8?B?UzVCWUFDS0Z1TjBSak9ndS9mbVBCSXdDQU9sblNkb0RuUjY0d1A0dmZoTUdG?=
 =?utf-8?B?Q1g2N1VOdG9qTmRscGhoeFdoUncrZFpiZVp2MzFKUXdlR2RZRWl4NFEvcEor?=
 =?utf-8?B?RkxqaHVvcmRpVEJqQ0pvZU01VnRUWVZxM1ZhMFEzOFJsOWEvNXVxdURhUEgw?=
 =?utf-8?B?SE95THRqUEZUQVkrYVdVYzNjd3NNZVNZeTZnZlFpcUx4dVBFVDNiTVRpb0V3?=
 =?utf-8?B?UlRMS2VsWUdWdDIva21USkc0RFpRRUttTm0yUkRSanM5QWl3YUZWUm5xNTk2?=
 =?utf-8?B?V3NwTHZ1Q0NkZU5KbjkzUm1LekhiaXc2V1JYUE1lOEpQV0VVZnVmM3lESS82?=
 =?utf-8?B?NnF6eHFWSm8wTnNyZm1GUHNvQ3RDSWR2ZU8vTS9vVXN3aFhTZXU4U3VXelpT?=
 =?utf-8?B?OUtVTTJLSmxwaGlQeTNTcC9oOXBMN2w3Tk9sNE9rUE9nR2lDbC9KZkkwRGlq?=
 =?utf-8?B?em1kay9jVjdESnhSS3RmVHhZWm9JWTJmVENqcTZBSi9jWUdSbTVjNFZrV0sy?=
 =?utf-8?B?S2Nyald0ZDI1bGdGQ0x1R3kvS0t0Rzl0dlpmVmM2UFBvNERFWkZjeHdxM2Rj?=
 =?utf-8?B?N1BrYXFmOHViSkM5QUhZaUtnSURrb0NHckpJOFBuRi9nWWZsazVlUmh1QWl5?=
 =?utf-8?B?dE5nNERIcDVMYjRvK3NPSjV5RXBCaGd0Z0VKa0VIZ0E2WGlkeEc0STJGbEZC?=
 =?utf-8?B?ZFowNEs2RHh3VHMwdG9vL1RhdnVXNnVEZEZVRCszWlRIOUw1NmtvZkkwTmhh?=
 =?utf-8?B?eHVKbXV4Yzl6RkF4N2kyNGhTOFB2TFdDWjFPbVA3cXpMalJaVTI5Y3RtWGlX?=
 =?utf-8?B?cC9Wb1ZBQlVTWmNpUlUySVJEV2gydkh1aVJDeDVLekpWVytUOS9pNzdBOHdZ?=
 =?utf-8?B?bWtVWlBpODRyZklXelBkMVVVOGxlRktVTUR2QWlqZHNKY1l5dDJpT2JRWmdR?=
 =?utf-8?B?SkFMWkcrNTJBWXpyZDA4RVYzUE56ME1NaFNCQ2lFU2wvNDhZd0NLYUk3OElD?=
 =?utf-8?B?QnpiYmljRklsQ3BoMVdTRTcrdWxnNm4zT250NUVUOG4yZmhnd1g5TCtZOFdw?=
 =?utf-8?B?NUNiakpUVXB5SmxtNS9QTjM5MlpLa0RBZWRxdnhZZkc5SW90Ulh3UmFRK21V?=
 =?utf-8?B?NmJsZE1SN0l0U3lvMmxpWk1ZKzkrdzhCblZpSmZFN2ZBQkdKaUtsVS91dklQ?=
 =?utf-8?B?YTBWdCt6cU1ibzZoNlB1Wk41UnYraHExRy9rNXA5dUt3dlZlOXZGclViRzcv?=
 =?utf-8?B?bXFJcnE0b0VMQlpaZ0pteFhjcXA0ZTlRRjdTYjBzRGh5bCtFQ0doeEZjRzVi?=
 =?utf-8?B?WWpEMldaNlQ1bTBjQ1FOT3NWOGZvOSt2a2JjTDJNV3AvT2FGeFdkZ1NTV3JJ?=
 =?utf-8?B?Q01IRmROVDhPZlFxN1FNck90VENsSjJuVXBoYTB4bUlPaHlFZlhkSndwcU5o?=
 =?utf-8?Q?P7yo=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bd11cea-241d-4da2-4c44-08dd08ba589a
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2024 16:51:00.1767
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: geeOJCz+pacyo+eF5VUHRMsgewV+LAVrPeilwCkHpxFemYwflibvdstu2f6jlmX3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5903

Hi Reinette,

On 11/15/24 18:24, Reinette Chatre wrote:
> Hi Babu,
> 
> On 10/29/24 4:21 PM, Babu Moger wrote:
>> --- a/include/linux/resctrl.h
>> +++ b/include/linux/resctrl.h
>> @@ -354,6 +354,10 @@ void resctrl_arch_reset_rmid(struct rdt_resource *r, struct rdt_mon_domain *d,
>>   */
>>  void resctrl_arch_reset_rmid_all(struct rdt_resource *r, struct rdt_mon_domain *d);
>>  
>> +void resctrl_arch_mon_event_config_set(void *info);
> 
> An architecture that may want to use this would need to know how to interpret
> the info passed. For an API I thus expect the struct it points to to also
> be available in this header file.

Sure, I will move structure mon_config_info to resctrl.h.

> 
> 
>> +u32 resctrl_arch_mon_event_config_get(struct rdt_mon_domain *d,
>> +				      enum resctrl_event_id eventid);
>> +
>>  extern unsigned int resctrl_rmid_realloc_threshold;
>>  extern unsigned int resctrl_rmid_realloc_limit;
>>  
> 
> Reinette
> 

-- 
Thanks
Babu Moger

