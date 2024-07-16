Return-Path: <linux-kernel+bounces-254529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25316933459
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 00:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06312810A2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 22:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD27614386D;
	Tue, 16 Jul 2024 22:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wGTIi3p8"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD906F2F7;
	Tue, 16 Jul 2024 22:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721170026; cv=fail; b=jEk8632NTuK9lBlPSNO0905mIn+oxvbT7imIcZBOtGu1NF4DJ6ZXMmBfwVwThgacadPFMBw1lBu/FBcJHJ6e8NEsZ3ORH220zxn+gF/+3vNuTgsSh65HPWL+nL14yjzZmQMCfGAbBYQQ43xeviTQZY8hPf8kvqR1O2iEwqkAGmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721170026; c=relaxed/simple;
	bh=juxm2UjBmOFWL/IrQrwg4YDwQnVaNMVT+aQvmfbnThw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fQxllCk6D2b7N+jUWaio/fZk93TIQTwLKuEqvmUm7GYwhJY4eHKFfk+dUt8U/Fvt2thJjkz5v8BCU9d3z1r/DjTak1PClojCsbNf9bVJT3OOE7JpHviuGCPfKatGuOgZ80VIUjcfKtez8IG+HLcOGXu+fBZQ2x4cATxHuKtfnFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wGTIi3p8; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dk/JHO4vKJ2D9pAfHjNodCVEZQX/6oVaqqN0fSyH2AU9FtmAlnXa7ShnoDbEaZ7xwbKsDxDD7igf0PlQxfDiChYsRU0ZteRp9k5wuQ9k9z8JydpSN3HukD6rJ4Rd3DUFNzH+9eSZRygFOWsD5Nn0Elde+rPRy6h2o17Org13+9zJGlZGxKJxTCLct2VDsCGXjXbQt6H/d8nTPeNthK2rlbJu6TJjsDHkie6OKheqnvkZ/gG8kmFUxIMvR8sVgTsSYv0C77dn2AnoOf5ejWcj9gWAutezhEFwon+SK6VlFRoPjd9BE6gD6zhp/vtI/Ur2Z/XIpnrSIlj8k116He+UWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKZ2q+E+0OkC0aKq4KMUk7tgNOTJdw5MTq8tTznlaXc=;
 b=Onysl9iqFXt1yp2Bmys+P6WeuUGvi6oLNSEQH0G6GL5PD4e3dxSCf/IOu7Rlqff9pOYVrD9f+4tVjrFgx6hMBmfCgmTbOhE1Yws0hJO5Ba/mPaXmVkXtlu9t84IFl1KT/8cy5oz5/q9+Xrq0mqlXqs3bUrd9oijyFBHbURdG+aA91birNcPVUtKc7GnlCZvvGxuBnXrM63Mn0obocEabmnwQaecTU47wy1rFSv9+4W24heKyMZy+sbP+Z+L9oCt342QFBKJyv7yJ7VZK/UpVngwypFb51B6T/4s074ok7NiV0T8KFTm2nLv1qYrXlUeRnpfJMOra/mbrEh/h+m5ErQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKZ2q+E+0OkC0aKq4KMUk7tgNOTJdw5MTq8tTznlaXc=;
 b=wGTIi3p828nmUhyAV1T/FfgpcDUqz+PQi2GE0Li3hYVoWJs5f7w4DKLOOi3NWyHfQxdEq/IYq5vpaNoVzg9GMafjuuRTQFYt4BBpnCi8nqmp7ecPK6tnm2ABuowwj8AHfP9j4sThl8LGUCP8/EKUcdu30Vfk+OGWnmuxinty45s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by IA1PR12MB9031.namprd12.prod.outlook.com (2603:10b6:208:3f9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Tue, 16 Jul
 2024 22:47:01 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::d22d:666e:be69:117f%7]) with mapi id 15.20.7762.027; Tue, 16 Jul 2024
 22:47:01 +0000
Message-ID: <ac5595a8-b3f3-7f9a-c297-1b7d0220da06@amd.com>
Date: Tue, 16 Jul 2024 17:46:58 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5 17/20] x86/resctrl: Introduce the interface switch
 between monitor modes
Content-Language: en-US
To: Reinette Chatre <reinette.chatre@intel.com>,
 Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com, james.morse@arm.com
References: <cover.1720043311.git.babu.moger@amd.com>
 <cce527151843aaa1a6001c75a17ee46108821233.1720043311.git.babu.moger@amd.com>
 <0815b30c-8bff-484d-895c-4f40e9b2d1db@intel.com>
From: "Moger, Babu" <bmoger@amd.com>
In-Reply-To: <0815b30c-8bff-484d-895c-4f40e9b2d1db@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0104.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::14) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA0PR12MB4557:EE_|IA1PR12MB9031:EE_
X-MS-Office365-Filtering-Correlation-Id: ec9c7544-02f6-4033-04b3-08dca5e934d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGlKemlLc0haUm5kWkJxOS9senJBTGViOXcvYm56WGJYaFc1dTg4YWwrRDV3?=
 =?utf-8?B?NFB5a0tQN3EwdW5UT1pzZUY5NnJUOVdQT29WbDNTTUw1OXh3RzZQcnMxNG9v?=
 =?utf-8?B?SkVzUTcwSitJbldBVFlueURaKzVyRTAxRU9qU2FnZXVtclJMVWpnWmp0RytQ?=
 =?utf-8?B?bGpvd2lEUFZueEtJOW82TVAyUzFPU1Boc2FUNUhUN1hVbFM5WHBqaGV1WlNu?=
 =?utf-8?B?UUtkRkYzcXIzWDNZcjI5S2docDNzN0JNa2lrWFVQT1o3R3BwRUJhWDFDYXlE?=
 =?utf-8?B?cVVVRk5TSU1VUG1vOWRuNi9xanV5dWRoSkNlNVNTUEkvbnhCODJsM1VraFRr?=
 =?utf-8?B?U0VKZXlUR1d1cFdPVkp0RFZEbUtaT3Y5amlYVzNMUExONXJVWURFTHhCSzZQ?=
 =?utf-8?B?YTc5VEZPak1BRXNiTlczRFRBTGw2L1NoSDRyeVR3L0p5K29zdUNPUmtjdzFR?=
 =?utf-8?B?Q2F0UTh4MHZKNnhadXdPMkUzbzNRbjB1dWVjMUcvNGNlaXRTWXZ0V05TSFdV?=
 =?utf-8?B?elRuWUwrQitnWmxicW9TN0grOExxUlIwVHhGNE1hM3dyeGMzRFkxMlVpckVo?=
 =?utf-8?B?REE4cE9zSUYrOEcreHcyMWp2NWkwY01vQ0U1Nm9RNGRNZStJUzZIcHZKcUxO?=
 =?utf-8?B?Uk5GNzYyLzJIUCtTY3pZTmhSdFViMFlkZXY0R0lKbFhjdVQxZTdwVVdBMVQz?=
 =?utf-8?B?dUpydFlMZjNtazdiUUtlc0Q1V3N0czdwaWFqSDY3TStYdVNFNm84clpKeURY?=
 =?utf-8?B?R2hGb0xvWmUrd3Q5bXNqdEV6aFRqL3NnY2VmL0g4emlmRzJoTjRhMXJQcGRs?=
 =?utf-8?B?WlIyT2g0V1pvZVBzUjQ1Sm8rZnl2bStBbzJZRDBCRXFLa0QrdUZodjIxUEdB?=
 =?utf-8?B?ZjJxU2FpUzlmTUFWcVEzc3dwcVpiODc5b0EyN1VXcVFQR0J2K1J5cUM2Vy9q?=
 =?utf-8?B?Mnl2cHo4KzVyMTVpaVlrclFvSHdValJxNnpPME1sQU5OS1U0SThwbFlFR2tr?=
 =?utf-8?B?aTJXVkkvZWVaU0VZMDFYY0dGd2JHVXRGa2lwTitWS2ZxWXBYZFhYM25CSGg1?=
 =?utf-8?B?Q2U4c1hUOHYxa0pyakw1Rmx2cFVaSnJsMHE0SW5iMWdndUdtTXI1MkhTeW9V?=
 =?utf-8?B?bnBoaEJPY3kvaXJrbEpuWklaL2RVNFMybU5OdURCS2NjMS9DYjdIYkp4M2hD?=
 =?utf-8?B?dGN0NStLVk9oMlZQbnd4OHVGZlpBVExlckRZL2pnVEZRRDh2YXE3MjBwRFNQ?=
 =?utf-8?B?SmtGZzJQeExBOWVjU1pGZjhWSEFyNGwwcUZacnNzY0FxemowMU8wbkdmOXlC?=
 =?utf-8?B?V0tBQlNHY2VkY3I4RGFUMGdMQ21EN2N0MzhoZnlDWjFDcVRha1g0YkY0dlY0?=
 =?utf-8?B?QTdmYWJqQVZYUmthZk1hT0d3L3U1YXh4RURMdEV4dmtZYVpocHh3QWpqamZK?=
 =?utf-8?B?RWhQTEdxTVM5VEpKZ2dXU3RGZnIveTZ0cFB5RkFrbERNeW9mb0pqMzc3clpa?=
 =?utf-8?B?b2Y0a1NSOUdZWllrcGQ5MWVpTXUzOFNUUDNRZ09BSmZhL3NEKzBwMGNiVGQ5?=
 =?utf-8?B?K2FuT0Y3QmUwcVBRcUJyaWs1RXlpL05pRlN3bFdWTzNjTGxOSEZaT0JmV01a?=
 =?utf-8?B?RG5qRXlpYldaWG82ZG9YWEdreUNlRTU5dHArRkY5dkhGOXdCV05xcWpyRHh5?=
 =?utf-8?B?WHlpektPWm81UUhSWUJyaENZU21yOFVRdWE5VDBrUjQydlkwY3dFUFVHRm9C?=
 =?utf-8?B?WGliV3VXN0ZGVlc4S2dueS9mRWZqSWxHaTltL1FoUXFWNkVqckF5Wm1oMmFt?=
 =?utf-8?B?elViWTNGeGFuVnRmQ1FmQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y2U2Wm04YUFtcVBPTjZ3cGtqeXlnWnUzM3E4eUZmQ3hxbWMvS2U1bTRMcHFR?=
 =?utf-8?B?NlZaamQwKzRrNzZWbjdyVDFZMlpHdnIvVVZFR2JEdU1CM0JpNmh3TjhQbFJ2?=
 =?utf-8?B?N3N1Y2o3Nk9udjVFaVEvdWt6eEtJa0dUMnFVU0ZuVHRoYjBaanNoemwrYi9s?=
 =?utf-8?B?N0ZZV0tIVVk2a0lnOUlBaG80Z1ZVK1MvWWlGbXZOS3J4UkpUWEEyRmRqZS8z?=
 =?utf-8?B?L1laUVFpZUdGazl6RWQ0RXA3ZzhQcFZvbVk4QTFDNW1JWlNoWElKa1hUbXl2?=
 =?utf-8?B?SEgyYWlUbTBlc2pRWDN1TFdLR3JKZHAzVFYrOHdGblg4VGUxSjBsSkIyYWtx?=
 =?utf-8?B?Uk9IMWwzWjVqSVZYWXdRell5QUkrM2oyTmpncHZoMVFSTWtaVzJ4KzlsOVlJ?=
 =?utf-8?B?MTdOeFAxTXF2NTV5Z0hQSldUWkRoZ2dJQjM3NXBiS2thNFd1RHlrRnN2bzA1?=
 =?utf-8?B?UzZ3eFRSWEh3bXNwbDFwMTlJWTFYUitFczFBUWhrUnpWQWQvVjBjcGYvWHgr?=
 =?utf-8?B?aXFBS3RxRzdyS3l1VUx3QW5ydmVHTGtSWnZydWVXbzMwQ0FwcHFuaUp5dVZO?=
 =?utf-8?B?QjNYUmlOckpuUUtUMWtmMEdEY1NJVFdaSWJjcDhHcUlNZHRLeFJhK2JCZnU4?=
 =?utf-8?B?aUV4Q05QK3lPUnk1cmZ2ZE95OUdyQkRTL2JoV0NUREwwUmxEU2xBamNKRlJM?=
 =?utf-8?B?bUVKNEVFdXc3c3VOQmI0QU9jODhBUytrcVJxMnI1WEFIcjBmOENJYzVnNGpn?=
 =?utf-8?B?bEtzRUZabStOMmZXSlVDNXRTZlNBNE5zaUYxVUxKVDFpWjlNVWFBQnRqRCtk?=
 =?utf-8?B?aEs5SjRlSHBRV0NvZkhTeXlSaDlnU3N6ZElsL05NdWFhOUs1aDgxcnNsMWtP?=
 =?utf-8?B?SEdVeGVRN3hobG1MeEdrNUc3SkNzUERzVzVFcFFURkNaTDJqYlhmL09TTHJr?=
 =?utf-8?B?OWt5OWU4czZydTMvbjdaMGgzU3hNNVluWWIxQWFvZ2lFRThJUXNsUWs5VWZj?=
 =?utf-8?B?ZGJIZStYWDd6MFEzekl0cGhkMUNOM29qREdENXNqdFUyWHB4RkVmK1ZWZTZ2?=
 =?utf-8?B?cEdXd2g3bms0Z2FTcmZWQWdPMzNPZFF2NGtBcEVRdmIxdGFhODluUlZTdDJG?=
 =?utf-8?B?V283aGJwdHhxTEhXdE8zaE41SzdGcUlFUHFJbFBjZlc3b0tRRkozWVVkZVNs?=
 =?utf-8?B?WmtNUi9ET3Rkdm5xTDhKRHVyblZ3bG5PSXc1a1hKMFRzcE5sazloamJldmpT?=
 =?utf-8?B?eEJuaUsxdFE3ckhmMlVCTzVXNlNoY1h3Zzdsb0hnVmI3M0NBZ3E4a3pDZmlz?=
 =?utf-8?B?dmsyVEtHUERDdmlwUTFwVjloMGVLa2l3WlUzQy8xc21pUk9BS2ZYWURmc1Uw?=
 =?utf-8?B?V3Ewckg0clh5NUdDYVV2Nm5DZDdNNmhtUm9pTE5BZ3NIM3hDejlqaWJMUm8z?=
 =?utf-8?B?NmhMK3RSNlVxOXAzVTYzUStRMUVwdWhBODRSb0pFSk9SSzFiV0dNVjdyT1Z3?=
 =?utf-8?B?OEVIclBCdkU4S2pPb09HbWhzZ2hoZFROcFlYeTA3L2hMcEk5cm5UQlJwNVZL?=
 =?utf-8?B?cm53NStuVEtuSHJmWU12bEVlL0Q0Z3FSdDB6TjlzdFZPdGw0M09vQ0ptK0FL?=
 =?utf-8?B?R01uUEdUNFdBampqQkhEQy9zSzRsQ0sza3lOUlVOSmVocCtkM05pZm9PU2li?=
 =?utf-8?B?bWhNWlRoOSt6cXh1MUlyY3E3aUxHVjZDa01iaDg3V1RSUmhsY0ZZeG5hUy8v?=
 =?utf-8?B?TGtWcDlrMjNBdG41Q1Y0ZW9nUVY2ZWhEK0wxODlFT1Mweks0bzVXVnBEZThE?=
 =?utf-8?B?Y1RSUEc4T3oxMGJ2RWJWUDNKb1c3OGdud0lwQ1p0a3JYc2NhY3A4R3JzMFFG?=
 =?utf-8?B?MmUzY0pwa25acmNXZTFSMHM5ZDBYNEZGL1l1bGpmYWJ3VWFBeU82bktoMmVn?=
 =?utf-8?B?NlF3U3Z3Q290bG5XN3RHdDZESDdZdFN4TVNycStYeWJDQ3pBS2NlTlFhZEVo?=
 =?utf-8?B?eEszR2grNloyNXBCZGdqMzNMWXB4b3BlZGV1eTNZdklua1hrREd6b25IS2hI?=
 =?utf-8?B?bkZuNy8zZlY3WnBZTW9CL3QwNTd1UFJ2RzVsWXl1WWsxUmhxcHZkZ0tZM2F1?=
 =?utf-8?Q?Xxlsv/oEHZ+0elqeAPs43XnKm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec9c7544-02f6-4033-04b3-08dca5e934d4
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2024 22:47:01.4387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3qvDG7NSxViFuLrCpWS4+NbQP0ftrTrlzGPLeFwWdZib0LVxMLG4o3Cf28nhrdLk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9031

Hi Reinette,

On 7/12/2024 5:14 PM, Reinette Chatre wrote:
> Hi Babu,
> 
> On 7/3/24 2:48 PM, Babu Moger wrote:
>> Introduce interface to switch between ABMC and legacy modes.
>>
>> By default ABMC is enabled on boot if the feature is available.
>> Provide the interface to go back to legacy mode if required.
>>
>> $ cat /sys/fs/resctrl/info/L3_MON/mbm_mode
>> [abmc]
>> legacy
>>
>> To enable the legacy monitoring feature:
>> $ echo "legacy" > /sys/fs/resctrl/info/L3_MON/mbm_mode
>>
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> v4: Minor commit text changes. Keep the default to ABMC when supported.
>>      Fixed comments to reflect changed interface "mbm_mode".
>>
>> v3: New patch to address the review comments from upstream.
>> ---
>>   Documentation/arch/x86/resctrl.rst     | 10 +++++++
>>   arch/x86/kernel/cpu/resctrl/rdtgroup.c | 37 +++++++++++++++++++++++++-
>>   2 files changed, 46 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/arch/x86/resctrl.rst 
>> b/Documentation/arch/x86/resctrl.rst
>> index 11b7a5f26b40..4c41c5622627 100644
>> --- a/Documentation/arch/x86/resctrl.rst
>> +++ b/Documentation/arch/x86/resctrl.rst
>> @@ -291,6 +291,16 @@ with the following files:
>>       Without ABMC enabled, monitoring will work in "legacy" mode
>>       without assignment option.
>> +    * To enable ABMC feature:
>> +      ::
>> +
>> +        # echo  "abmc" > /sys/fs/resctrl/info/L3_MON/mbm_mode
>> +
>> +    * To enable the legacy monitoring feature:
>> +      ::
>> +
>> +        # echo  "legacy" > /sys/fs/resctrl/info/L3_MON/mbm_mode
>> +
> 
> Needs details on what user can expect to happen to counters/data when
> switching between modes.

Sure. Will add the details.

> 
>>   "num_mbm_cntrs":
>>       The number of monitoring counters available for assignment.
>> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c 
>> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> index 475a0c7b2a25..531233779f8d 100644
>> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
>> @@ -910,6 +910,40 @@ static int rdtgroup_num_mbm_cntrs_show(struct 
>> kernfs_open_file *of,
>>       return 0;
>>   }
>> +static ssize_t rdtgroup_mbm_mode_write(struct kernfs_open_file *of,
>> +                       char *buf, size_t nbytes,
>> +                       loff_t off)
>> +{
>> +    struct rdt_resource *r = of->kn->parent->priv;
>> +    int ret = 0;
>> +
>> +    if (!r->mon.abmc_capable)
>> +        return -EINVAL;
>> +
> 
> Why should a user not be able to write "legacy" into this
> file if "legacy" is the only mode supported?

Yes. Will fix it.

> 
>> +    /* Valid input requires a trailing newline */
>> +    if (nbytes == 0 || buf[nbytes - 1] != '\n')
>> +        return -EINVAL;
>> +
>> +    buf[nbytes - 1] = '\0';
>> +
>> +    cpus_read_lock();
>> +    mutex_lock(&rdtgroup_mutex);
>> +
>> +    rdt_last_cmd_clear();
>> +
>> +    if (!strcmp(buf, "legacy"))
>> +        resctrl_arch_abmc_disable();
>> +    else if (!strcmp(buf, "abmc"))
>> +        ret = resctrl_arch_abmc_enable();
>> +    else
>> +        ret = -EINVAL;
>> +
>> +    mutex_unlock(&rdtgroup_mutex);
>> +    cpus_read_unlock();
>> +
>> +    return ret ?: nbytes;
>> +}
>> +
>>   #ifdef CONFIG_PROC_CPU_RESCTRL
>>   /*
>> @@ -2103,9 +2137,10 @@ static struct rftype res_common_files[] = {
>>       },
>>       {
>>           .name        = "mbm_mode",
>> -        .mode        = 0444,
>> +        .mode        = 0644,
>>           .kf_ops        = &rdtgroup_kf_single_ops,
>>           .seq_show    = rdtgroup_mbm_mode_show,
>> +        .write        = rdtgroup_mbm_mode_write,
>>       },
>>       {
>>           .name        = "cpus",
> 
> Reinette
> 

-- 
- Babu Moger

