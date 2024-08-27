Return-Path: <linux-kernel+bounces-303485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0BD960CB9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 15:57:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9788280FE0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 13:57:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D771C3F0D;
	Tue, 27 Aug 2024 13:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CGgFF4cU"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEC773466
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 13:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724767043; cv=fail; b=QgT02MQIcNMWTgbE4+r9Ss/aST8auZjnmbP2R1g06O9f5plNnqSpblj5sV2wDWoz1e5qOyvFqZVARuKhAYar1mwD6CoPVQpLQCjSQY8Ag/j2J3EFQqS/3oay/i9obA+KN9NKAc2ardh7Er87JXvcpLd29/WNetcx00jMMxdETCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724767043; c=relaxed/simple;
	bh=UQG3Un5L03ryeQU+mdvdrlwl47fhq7NBs1r5Xyla3uw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VDCEYIEb5M0xMyjnVkJ8Mzb1bLHozXpl/TAp8mH/SUsjMCdms/Ld9tGtHvKQ+ndRys3lOvbZKxX7SPpre67sBWodbL0NzTUVX74nMlBxcKjNbvkyi2hSgizlKkCIN5YwKYZvngPkOumj+PoMUJRXhlCn+Kdt1GWjaZR9yoz+tx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CGgFF4cU; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X860Pccu5lDWp7NGXMei49sN5R0XFfQnHUfKBNLjvVKX1rOw/0BHkUOE5wEmbb9lcpg4UGwuVnBOJ9sRNHxymKeN72P3ue/Znlr2TvePSHfaDqk6FOstJYE0K/Yh7TGYQqFIz2vPyZEMdJdoYh0tlLHiX1XLP0ir7vcCVkvrst1BJm3HIH+w4eayP5HkECAcrsH+C1tEm3kWuCegH7sTSjVHx6+Di4zRcxqZEuHvM9QE1jSdVs92LV9pbZ7tiPDeN09JaAhMBPWH3mtmXHqjmEqBXZMo5Qqh6MD0CjhwEKweEotym83hpyBS4QZqQL1qmRVR2lFbf+1fTifgJQODsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/EdaHRUrPMzDVx9PdVtC7f0O+IPfE2r2ml1pu7p7IU=;
 b=k19kr6Bb4ZYKZYdbYZv408S+Hqb70ltsBFfPGNTcPvw1zD6Yxsl5bnStJ6UAW9pU94sc4DgWPc9D80P/sbwdZXhBdZ7RkIrBYntRrR1f7LXQhJxvFbT2y+g9lQWNVEp+qnPO8qUB7TPusq0tUGu2rW9FvmIo1ifdm1AUJ98a7Nl+byKrwxAyoO7cA5rrxpRj08jWBCTxXf+I7M3No2xxT8TQ4NNhU7qm/NQSlG0D0X+UsN3GFgUeXe1HjOQovT2bC1FDMPG0nDP6QI4/kCne9c5B3iSswj2zNGYdq3YqfBVnTnzOvUtCjijBY0YPC8u4CGdL00z0lCg0+nZ6392Z7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/EdaHRUrPMzDVx9PdVtC7f0O+IPfE2r2ml1pu7p7IU=;
 b=CGgFF4cUyvBBmTlTNdQdbju+s4IJzl/i83PxC/yUJ6khNKSc5eB0sjth7BVfTfEAtkJKCFUjLxlVlUqm6YyALDlxpvlwracjetoelRU52jTe+BhNBfm0c2vFU8EZiFSoaM98DWiKTnKFOOdIxFPfCgD3LWavEeLw4WSyA8wjKA8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by DS0PR12MB6629.namprd12.prod.outlook.com (2603:10b6:8:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 13:57:20 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 13:57:20 +0000
Message-ID: <b66bc23a-56d8-7115-4641-5869501ab114@amd.com>
Date: Tue, 27 Aug 2024 08:57:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/mm/sme: fix the kdump kernel breakage on SME system
 when CONFIG_IMA_KEXEC=y
Content-Language: en-US
To: Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, noodles@fb.com, x86@kernel.org,
 lijiang@redhat.com, kexec@lists.infradead.org
References: <20240826024457.22423-1-bhe@redhat.com>
 <35e40987-1541-cbbe-6b16-1ddadc2c4c35@amd.com>
 <Zs1j31JGB/5EJatz@MiWiFi-R3L-srv>
 <CALu+AoTNtzVGFyG=GLAtT=VEWJG7FNbx6jD_Ye+4ORYXOiMekw@mail.gmail.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <CALu+AoTNtzVGFyG=GLAtT=VEWJG7FNbx6jD_Ye+4ORYXOiMekw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN7PR04CA0019.namprd04.prod.outlook.com
 (2603:10b6:806:f2::24) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|DS0PR12MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: 766d5daa-3735-4dc2-edba-08dcc6a02b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OU9hZmdVL05Bd09uSlJUWlRqdlNPemNFMWRpK204MTFBL2FzNDlNalZGUWdQ?=
 =?utf-8?B?RTJEYTQxRVkrUGVPaWlHOHBXVVBEbzBjTmJaa0J3ekFPUHRCaGpUNVgrY3lo?=
 =?utf-8?B?ZlBUL0NQRXZQNkRjdzJTK25JM2VzRUQ1MGUyZ09nOVVqVVd0OGdselhlaDRa?=
 =?utf-8?B?VnM1SUpVSUI1NUxBcVNxUVVqQVBieXJSRXlmMjJlYjJROEpnUklhWkhiVVVS?=
 =?utf-8?B?U05GQUtkTmxTcTN6dG1iOGhKTUhuM0pnSDNSVEEyVW5mNEYvK1Q4dWZVdTlC?=
 =?utf-8?B?d0VPYXNvQzJRdkdwUm1ZU251eUlES1FsMjBZVjJWK1ZJNUtiTFkyVEhPTW1u?=
 =?utf-8?B?Nko3Y0duREtEU2VZSzRSYXpVeklsMGJRTHRkcXRoWVlnS1pqNDhUbEJKNVds?=
 =?utf-8?B?RWFpT2RiOS8vWWNwOUhiMkFUY1h4WjNReXllOXMwYUwxRkJTcXdNRjZpc2tY?=
 =?utf-8?B?RkNzRkdNTmptaEcwS3BrZ0hkNTZ0aUU0T2QwWlZHU3NpMW5hV0RSRTdaOXNo?=
 =?utf-8?B?SUVkLy9UbjJsVVp1MEhIc1ZTVEw0d1NCMndwRkJiVjY2ZTJWVU5VditCZHZT?=
 =?utf-8?B?OGtZcjJaRnJyNXNtWnNqSktVTE5Qem9CRUExamk3bXdtMEIvMWpPZ2Z6NE4r?=
 =?utf-8?B?K1VWK1NyOHVheWYzcU0yNGtPOENucFQyZjA3UlRXY25udDMwMG9sNm9tMDcv?=
 =?utf-8?B?Z1hCdnJ4azMrdVdNRUFnbDlQdHJrM1IxTXY1T09TbWpLWUVoUW9DV3hPeHV6?=
 =?utf-8?B?UlltaXh3MzltakY4SitxZnZZZjI0SU9uODEwWWZ4a2pxRWJ3ZnM4Ri85VDJk?=
 =?utf-8?B?MVNkNFRqUHFRQVlNSkUxcHMvS3JNbDFGQVJPMU4zUWZvOHFlYzdqRyttMDNt?=
 =?utf-8?B?d1krZWxVSW9HTkZJcEtLT2FaYzVTczdyMGFBeUhXL0w1UDZoQ0NOYmwzazBN?=
 =?utf-8?B?SzNVSXVWajFYa2RPWWZCcEJ2Q2puWHNBV1BnRzQrK3UxSVEzZUc1QVBYcTB3?=
 =?utf-8?B?ZmhOK1JGWm5sSk5zKzJ5RVRHck5pTld2aFpUUVFPaDFiYW1sbVhjczBycUVt?=
 =?utf-8?B?TVV0WnZvSHhnenpiLzJjRFY0SWFCcnFFcWtXa3RhN2d1WFdDTEl2YnNQQ1JG?=
 =?utf-8?B?S3M4OTIwRmw4SGtkM25pbDJ0S3FPOXYraTNzOWlQTVdLR0JhUHFobmtBcm95?=
 =?utf-8?B?VEZGVGVyWFJqekIydVhKdGphN0xiN0xZMk4wbXlLMzZjZVZOQlpZamRPalIv?=
 =?utf-8?B?MmY2Mkd4M0JKakd0RGJ6L01PSktqNzdndDFkU0h3SS85MjJmbHRWR3BIN2xm?=
 =?utf-8?B?b04rbm5laHo1U0NHZ216bWMxZHkzZVlCekFPaXhZUGR4WG1TcVZtVHBpTy93?=
 =?utf-8?B?Y25VdEZoSGs1cmtVN1J0WHFlVkNmV1hJNDZlQXVQaEp2dTRRQm84WTRqTW1G?=
 =?utf-8?B?eGlscHBGYXRTSThpVmVVSGM0UHJHOVBnRVpGNDBpK2VMZkI0b2lLQjZxM1g5?=
 =?utf-8?B?WmRQQ3hhZWlKcFhadnVWTnpqWkI0RVRVZlM5R1ZlNzliNlo0bCtNbzBFWFd1?=
 =?utf-8?B?U1FWS1A2WHpKK1Q0QjhteWdVbm5qeElSU3ZJRDlnV3RWS3ZpSjZKSG96V3V5?=
 =?utf-8?B?U1JvZXdFZUtDK0Z0cjJ4UVlTckpocVRITXE3YVRxZGVBVyt2OUh1MUJsSjA3?=
 =?utf-8?B?Y29hbzBxWUVod0dLR0JwdVdPaE94aFhnNnluemF1WU5kQ0JSVXhkZ1o4SU45?=
 =?utf-8?B?YTk4UXAvdk5pUGkzcnBWVkM0eEx0cFFsbWdvK1UxTDhtVE5WRWRjdllrQ1FE?=
 =?utf-8?B?NmdscVk4ZHFKYTRxMHJZQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWJZUUQ1VkhENTQwQTB2citra3V3TE91ZGVMMW1HUGZBa001U0JDOGFqL2xK?=
 =?utf-8?B?WkRGeTFOZUpLZUxsbmNpZFh0dnJMb0d5M3k5WTNxVU4vTmsyMGZGMURJNUZL?=
 =?utf-8?B?SGNkS2lReCtUTHEzZFJ0L0Y3TmpaS21MeTQ2eVZTRUFVbHdzRnhONUlTUDdt?=
 =?utf-8?B?eUhUNHNibS9LWXZRMFl2bDZTd3VmMnllSVoyS25RanU3dW0weThwWkVOY05o?=
 =?utf-8?B?dXc4VGJ2YURXWVJsYlJUK3hKTzFoNm5Tc2lyWm9PbWNwZWdQZGVPNGQrMkRM?=
 =?utf-8?B?c3YwNTBsSGRMa25JRzBwdjkzY1crZHloK1dUeHlLcklIeW9sSlVsK0lrTnJB?=
 =?utf-8?B?OG5CYTgwZFNNOG5CTy84ZXppYW1wZnV5NUFPc2Yxd0VIMnFDWVpFdDBJZWN0?=
 =?utf-8?B?WVVYYnYzTkdXN0x4ZENKaXdBb1pRYk5BOE9UYTlyNjF4Nm9HYldHQTNmM0lY?=
 =?utf-8?B?bUFveklwVWdQVmJZVUo5M2dIWTZOVEJ2bnEwbnQyYXBQUWVWaHBtSDNlUWNH?=
 =?utf-8?B?YWJuNzNlQ2RTYjR4TGN1SFFtUTVYVWxyQVRWQ2tnS1E0NGt5UWhEcEZrN29R?=
 =?utf-8?B?eCs2cWFoYzQ1SUs5Ynh3dUo3bElQODQ4ZE04NG5kQjQ2N0dFUEdWS2RqbnRR?=
 =?utf-8?B?blYzczBmNWM0Ty8yM2Z2OXozUUlOQ0JSZWM5V1gwVmZnU1VNRHdCUUhuckx3?=
 =?utf-8?B?dkZYb0ErVHIrWVBXZUF5RlJ5U0VoVXZFemE1NDJpT05GRjJZV21zejNGRXd1?=
 =?utf-8?B?dDNIVWIvN0hOanpNMjRqc1B6MmU2MlVLR1ZoZUdTL2RmdlBFNnJFa2hWUlNl?=
 =?utf-8?B?dzkzMGR4K25nUUhwdVg5WktGU3pOT2UyU3FWSEFaT2FqYVNiUTh2ejNEUWVI?=
 =?utf-8?B?RDk0OTRlNnVJUVBXajhCVzVZeHB2MXdUdytYelF6M3JNdUc1WTB1VUVGczdi?=
 =?utf-8?B?R0pFdXJsajZrS2d6dkhaODV4MVdveS9ja205R3NkTStFb3dBOVhjcTNXNUtR?=
 =?utf-8?B?dXd6V2hCalp6ekNnMndPWVByV3FJOElLUWkxcldXMzZtK2FoV1BPbytXVWFh?=
 =?utf-8?B?UXVUM21xT09rZ0dreUdRblY5SmVnczllVllTejkxT1Q3TkRTSWp5V3hMbzRS?=
 =?utf-8?B?SENkWDlpc29TdDEyMmZPM2NxNEo2SDc4aGNEMnBCN2J4R2RZMlhvcFZuUnBC?=
 =?utf-8?B?UUVnajFHcE1Xdy9uRUtYdXdSUHpZMDdwbnFwS2phYkh5QmlyUFYrMXRRUndo?=
 =?utf-8?B?Tmc2NUdjSlA2YW80dGdDMTNPbUpMMXdLVkN5RGlXbGJPNnFHZThnM2RML2w4?=
 =?utf-8?B?WWgxQ1ExckU1OUpaU05WeGg2WFE2ZlhuUnFVTnJGOHpNTEVrWkhsTUEwdGdR?=
 =?utf-8?B?MzlEYnlHbmZVcDhIUE5nR2RxQmh0a2g4QTdzajRtRHRleEZzUTAxdkVyZW1y?=
 =?utf-8?B?RmMzMFd0eVNsRGZ4Z2VBczdjWERDUmQzSmhJRFE0TjMxL1RkY1ZSRmd4QS8r?=
 =?utf-8?B?cERqTWJ4R3E4TTZGNzlWeVh1T09LMVVyT1h4NDhNT1hPeDVIVnJGRDREMTli?=
 =?utf-8?B?eXArZlNIaC95ZTBaL0RyUGZSNzVDUS9CYVJEYVUra1RBc1V4TUJvcHUwNHJH?=
 =?utf-8?B?eTU0UlYwekdlMEFMQVlZNHFjSWV1Wm5LVFU3NDdiTDNUZmFtdUR4L20xUTZr?=
 =?utf-8?B?VXpMTUtyeFFaMHVPbEw4YjdFVkdTdnNDRmcrTGcvM2lYSjhVMUxYcDJZYit3?=
 =?utf-8?B?RmlRd1NIVnY5OFpNd09nV04raUZyZG9TTnEzYmxFRFU0cGRZUHVDYnZPeG1H?=
 =?utf-8?B?TEdFd0g3Smh6czFYblkzUlF4dmsyOGNJdGw4THlMdmd3T1lKc3FFYjdiTUdF?=
 =?utf-8?B?cTFFNTQzUjFmeVZYRmVEUzhPZGlIZlVMZGpSMU1adGozbXhrQzhFSVI4Sk5p?=
 =?utf-8?B?WG8xSHE5WFhKSW0vYlhHS2hpeXAvOEFkTm1jakQ4UlFzVCtoRDJ2TEdENTdY?=
 =?utf-8?B?TDF6MmRESnlzTG1sdEJGNkYzbm94MkVuaS8waGFqTDFNWnNPb2FUemVmU2wy?=
 =?utf-8?B?akQwZkMvSjB3aXJHekl5QXFHaE1FTUQyOTJ2MVA5d0tjNnRaMGpsclBOckVO?=
 =?utf-8?Q?4I3D8hTGXCqWbzwkyzYLVpycQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 766d5daa-3735-4dc2-edba-08dcc6a02b09
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 13:57:20.0282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PAhmUMCzMmlK2QcV1FuIXDG8uIjib4fVw2EOChO0kkbWhWZUXKYahcSeCRk7iScHjVeBVXnDgRKpnsrgnSYPng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629

On 8/27/24 00:41, Dave Young wrote:
> On Tue, 27 Aug 2024 at 13:28, Baoquan He <bhe@redhat.com> wrote:
>>
>> On 08/26/24 at 09:24am, Tom Lendacky wrote:
>>> On 8/25/24 21:44, Baoquan He wrote:
>>>> Recently, it's reported that kdump kernel is broken during bootup on
>>>> SME system when CONFIG_IMA_KEXEC=y. When debugging, I noticed this
>>>> can be traced back to commit ("b69a2afd5afc x86/kexec: Carry forward
>>>> IMA measurement log on kexec"). Just nobody ever tested it on SME
>>>> system when enabling CONFIG_IMA_KEXEC.
>>>>

>>
>> I talked to Dave, he reminded me that people could mix the passed in
>> parameter 'size' and the local variable 'size' defined inside the while
>> loop, not sure which 'size' you are referring to.
>>
> Baoquan, you are right, but I think I mistakenly read the code in
> memremap_is_setup_data instead of early_memremap_is_setup_data.  You

Ditto.

> can check the memremap_is_setup_data, no "size = sizeof (*data)",  so
> these two functions could both need fixes.
> 
> Otherwise it would be better to change the function internal variable
> name, it could cause confusion even if the actual result is correct.

Yes, the use of size as a local variable while being passed in as a
parameter is very confusing.

Thanks,
Tom

> 
> Thanks
> Dave
> 

