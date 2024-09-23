Return-Path: <linux-kernel+bounces-335888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60CE597EC0E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 15:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D653D1F21FA0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFEC19922E;
	Mon, 23 Sep 2024 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jpF68Vp9"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E12119308A
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 13:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727097122; cv=fail; b=We/3r3hL4jtlbJJFPWe97EDd9jaFQbiCYt4zcn+/aw/fhE7gRgqbx/Q9ePkM7ZdCjQUjB189vAzbNvx56fgZL8fDg9SvNsj3i4mxVHcongFmlQIuC00L9COrNzqa3vqaSGXpuhRhd5beb/HFQfNEBtih0lD/1Wp2gze8Rc8PruM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727097122; c=relaxed/simple;
	bh=J7omcumexLVNg8KSxgbeTc1ZRARc4w01Ckcz9lH5LBI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IoTgiOmv0yaWONZRhZkElw0lsNXY7M9cDYAnEX5wvsXqNyKSkNg3FNGUVR2oCWvG4KgxhBOIr8qJI9mC5+pXsG08XTzijsHgDhgbHh1lhKEB/BGBdlfGbyZmQUquWugn0+2+miQWSq+wLjCmroWMliQndZnH2PPpRtUBWV9F4rM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jpF68Vp9; arc=fail smtp.client-ip=40.107.236.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uvn8IO+FLHVqtPqbrP7SmK5PtCl+YC2K0pYg4KA3LMao3fuz9SHrKMGK68W4dldsNSJ0GGmt1mIuqDi5ODlN27Ghk5MDnaFYT+XWFaiAczDLuSTWcGvAOQBT9vK/MLDssktgYARi7mNzUujz2OBPQzjFhOWm3gzb4DP05GuQqS4vtjOWsUTITkXST5llgp/XwaFFBHoscOmphB7zYSHRb8yDJJmGguJ3mJZCmtYEy7fpkiMMdY18tiu89XTaZYjFpDCcZa0FQgOYNVhWTqF7xoeDMaswC0le4MqQp9MpGqsWnJgJ1B4pnIVoH8jsq0ZM9lTRauTS2HUdndJfaSnDqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DI5ahapRAc4gaxTIQF0URcTP+cLjxEPeKrTj2Z4z8R0=;
 b=HsSIUeEvP2b+SyL1FX+ofNDklHlbZ8eiKxwqMB5IKiA7RdBfIVVUsGbQkYtcYgkNXppGKnwrNjGoncYUrKcRzDHpyNZfHjC8ekQKgecYJyJGX+MbW4lM4bjplVrRilKUzY86IVLk9BuojmQPrVe8FnRU3vYRXrNj3tz5I/JfHh0SZTeqDzuYdc1yA0aiLB09ZzYRiqEKBYlA+zlFdbEez4Yb5Do0V3lwQquehm5j++KpUSgVwwknZ6OautBUgDNRkO5YHGxpOUsU2ResM6tkDseR0MLgMwLGt/NXaK2a0f/jWL5aXrWA6FmumJIWdUe7GIuEYZXTnTTUFs9md6BCsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DI5ahapRAc4gaxTIQF0URcTP+cLjxEPeKrTj2Z4z8R0=;
 b=jpF68Vp9qY7AkZX3Ggln1Z+4ecHRU9riMR62n3XywYaFMZpjwbt1mU2BooHZ0SBGCOxYkEWZkL+8U7xW3KN2IbyOb3xJB2pE9lfp6AMyDEj3ldr9/xbYj3UWw9EgF40m4H8JMjiXBg/n1nN2ja+2ETnNNHLxru/ObE3cUSDKwt0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7217.namprd12.prod.outlook.com (2603:10b6:930:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 13:11:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::46fb:96f2:7667:7ca5%2]) with mapi id 15.20.7982.012; Mon, 23 Sep 2024
 13:11:57 +0000
Message-ID: <17eb00ef-f3db-4d42-a3fd-cbe6813075e5@amd.com>
Date: Mon, 23 Sep 2024 15:11:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Staging: drivers/gpu/drm/amd/amdgpu: Fix null pointer
 deference in amdkfd_fence_get_timeline_name
To: Dipendra Khadka <kdipendra88@gmail.com>
Cc: Felix.Kuehling@amd.com, alexander.deucher@amd.com, Xinhui.Pan@amd.com,
 airlied@gmail.com, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240920090959.30755-1-kdipendra88@gmail.com>
 <ac13994c-b77b-48f2-b2cf-20299f02c2e8@amd.com>
 <CAEKBCKMg0c5AW7YggDMR+Kg7OGq3dXApLK-=RTR71H0KHO73+g@mail.gmail.com>
 <ae062c07-dc09-4975-ad31-2f9d9ea435f9@amd.com>
 <CAEKBCKMNZOof8KP5upY45djTC9Bk9+AFHZyZVoid2eevTtjykA@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <CAEKBCKMNZOof8KP5upY45djTC9Bk9+AFHZyZVoid2eevTtjykA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ab::12) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7217:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e735263-b6c9-429d-00cf-08dcdbd14d3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wkk1NjFmczJZLzRFcExnTUNUVWdzUDRBY1ExZ040MTRldFFRQ1NKSzN5c0xz?=
 =?utf-8?B?anFqSWtQQnM5Qm1NamtnSnh3WUZOSjlSdkFaMnlITENtZnh4OHA4UUZKNzNZ?=
 =?utf-8?B?SjFjUStBNllHWldPenpPTlBzdDlad2s4aWd5eGlKV25MQXZjNmd2d1d4MWpv?=
 =?utf-8?B?SkVVaUw5OWFCRUpockhLVW40YTM1NG93UGFqd3RvZHRWNWZIRWRXaythVTdW?=
 =?utf-8?B?SE9CQVBMUFJCdU5hQ0FvM0VoV0owZjV6WUNJMFM4ejdVZUxreEdWdExJK2hi?=
 =?utf-8?B?eTA1ekU4dVM5L2E2MXdhblc1TzlXNXhpdkVJU0lBa1J5eDZCenVEbk9GK2xx?=
 =?utf-8?B?eFErbFRIVXVvdXJ6VGk5emJPc25CbnF0Rk5KY3dodXZlbk8yTmlEdVk4ckUy?=
 =?utf-8?B?T3FhTkJBRStlR2FmcXJJNG1Dazhhdm1yc1QwUzVtekVwQkZicElKS0ViQzc5?=
 =?utf-8?B?YTVQNXBtcmwxZFh3SDJ6KzRPLzQ5Q2FmcmVLMElyMzB1SXFnT0VJdHlCMnls?=
 =?utf-8?B?VFJxdmRMTDdrNWkwTXpiM3JLNnQ4Qlh6LzZGc1RWbmNFajNES3ZueWM0TWNa?=
 =?utf-8?B?c29pUmp0Y1d5RGNrM2RRRGY1Y2tJbUhiTk9rN0VheWVvNDRYekdzTk1JL2xR?=
 =?utf-8?B?SlB1ZHNVelNJbGdkRTFUWHZUVHBnWEhiVnNjVUF4KzNjT0hGOVBQVk1wQy9F?=
 =?utf-8?B?Ymw2M2s3STN0REhuUS9aL3pENUJjbURBWC9FSTVEcnMyeW1ReXhObFc2Y0tL?=
 =?utf-8?B?UnRpM0FBdjNNdGczaVh5TXJCNFkzU1V0amFkUk5tUWhkUHhySDZrQ1Vtd0w2?=
 =?utf-8?B?UDNrUlRrNll6YnJURTNERVdGeDdyYzVWS0QwemlkcnFOSVloQ3VPZTgxS3pO?=
 =?utf-8?B?YnVFS1NISFdOTmdlQndnRTFzWENLaEdQdUQ0TmhJa2FVbkpZRGxYQmpkcyt2?=
 =?utf-8?B?RzRHV3Zid2JYUmhUeWdmWVpISHdiV2FKTXZFT2pyTUs2QVJOZUpPUGRDbUJO?=
 =?utf-8?B?VEx6QTd0SjV5Q3JQdHBaMFppVEtNL3l3aUVLem5FajB4WkcyQURoSjBva3BP?=
 =?utf-8?B?ZERyV1RYemZtZTl4d2tWS21LUndiT3I4YVFzdXRnaFhDWkdOTkdOZFJxZ2Zx?=
 =?utf-8?B?K0dzWlQzWUVnck5YUmlZVmh6OEM2Qkx4WFBJZHRXS2hRWCt2a3ZoaEdLaXBl?=
 =?utf-8?B?bC9HTWJZV05ndHUyaWFteWJCdWFUZ2JRelVmRkZzT2t2VGtXamtUS0gzWCtG?=
 =?utf-8?B?U2lqaW9MK2ZEcmxyU1N4Zk1LV1dlSmZGWTBMUmkrVXF3V1VsemRDZC9hZ0tH?=
 =?utf-8?B?TXdUZFArKzZrL0x4cjRRdnZ5YnVKbVVSWlBEcy82SnNnOUxueGVJeVk0QnRo?=
 =?utf-8?B?NGtETksyVE5CY2FOWDF4R1o0SnhQYmFFWTRhWFJ4UHE4S3ZnM3pPc3VyTmMr?=
 =?utf-8?B?TjV0aWFlVUFnL3czRnZ5cEVPR2dtWGYwamNwc0ovSldoR2tXYlpBNmljU0tD?=
 =?utf-8?B?eVE3YjNvOG5JRXZEQllvRUIyNE5Na1VwZGlVZHZmMGhleGg3REVlMWUxdDdJ?=
 =?utf-8?B?UXpmQzhybWNvTk4vMGdGLzJZd01FTEY1WGtGRmlhVlh1VkQrTVFTNmxBa3Ft?=
 =?utf-8?B?Qk4rYXdidk9ZeEhWUXk5QmdBY0NsNlM2QktUSk11c0xBVllxRlRIWFVyRGcx?=
 =?utf-8?B?S1JBRnQ3dlZ0alVlTDdKYm5sYVpSUXV3a1E4aXl3eTJzR1dPdTFjRjZVRXE4?=
 =?utf-8?B?WkdLSTU3QXlNNVZ6dzFuSGZ0ay9YdVFDdHZ0OWVPZWh6bUpIWUlOU3ZsUE5I?=
 =?utf-8?B?M3BhK1FTRlE4d2loelRRdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5685.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzNUQklpVi9NT1prRDdRSzVvRTRQYlRSTlI5bjc3ZWRaaytGZzNaQ3hDaGl0?=
 =?utf-8?B?UERXcEM3U1AvYTN3aXB2WmFEYytnbGh3WVlTeUdtUlpXWWo2ekxXazBrSjZI?=
 =?utf-8?B?Kzg3am9sVFZDN09WK29RLy9lSGZ2QjZ0N0ZhYXo4dm5oRU93eFRlT2MrN2Rz?=
 =?utf-8?B?K1hKRWJJR2UyZ3d1b05BbDVPcCt0a0QyeWIvN1MvblZRM1hlcHAzaWtpN3V2?=
 =?utf-8?B?YU45QXFhYis4NGhqWVQ0OEdkSFZXaEkvWUhwOXVkZHlCOUlVRXlRV1cwSFR1?=
 =?utf-8?B?VjlZSlNZNW4rWTRqUXphQVhydEZ6WUxGeHVGdDZvU3YvTVIzRy96Qmc1aDBP?=
 =?utf-8?B?Q2NYbTZLckk4UkFxZDkrQm9TYTQvcUhOeHNKQldURG85RWFmaDlDaEgzRmF5?=
 =?utf-8?B?anlCOU0zY0hZV1l3dG4zYzRDR3d5QjBVeVZVNGRWY0VuNWN4d2RjNjczbEFj?=
 =?utf-8?B?U2Q1ZURUb0FJRlhjaGxlRCtvRUV2ZWtQNXJHeVRNTndrTGJoNUxhN2NCeStZ?=
 =?utf-8?B?dk03Q0h2V1RTNCs3M2lEWUN1eEU1U2pZbCtQUEt3WXc2WWNxSXg0S0s5YUxO?=
 =?utf-8?B?TVFudXBzTmMrOWZzbXpybURyR09mK05WSmhWdCt4SEUrUXB5cmFPVzZpc25U?=
 =?utf-8?B?aFZ6dldBeVJvNUJHSWluM1lHWGI0aGZVOTA4ZFg3OEdVdUFCVFJpSUlGekVk?=
 =?utf-8?B?M24rNTAzVFNPN3Q2NTNjS3ZCRkZKcUw1UmliNitmUHp0RGpyTkVRbEY1V0ZR?=
 =?utf-8?B?SXR6RXFOazZwY2Fkam5pSGZmSnEyb3pUVWp1TGcxQ1pMa1UzUFE0ZzBxRzhk?=
 =?utf-8?B?amFXMms4SkxuaGFnVXJXWGFDc0FybHlpYjVYR0ZMcEJJeU1PeUozdFRHb3VC?=
 =?utf-8?B?d204Z2RhdGJySERSSmpsdFozK3ZZR3FiUUlBT0lPbEZmOHpBbzVQWkNtRlFH?=
 =?utf-8?B?OEpmSnVCVUNGMHZWMnZIOHRVNHRVMHpzNVJ5WGxVdER0UXRKM09oTlVjRWpF?=
 =?utf-8?B?dEV3T0E3UlhYK0liVy9zeGI1cUloQUl6OEowUWNYd3I1aGlNUXY5MkhEbDdE?=
 =?utf-8?B?bDIzaWdYdDB0T1NVWUg0WnVYZitWdVFlRFNrZzZkcFk1SGpYMXlqR2tQbVNG?=
 =?utf-8?B?SGM1cG1xK0FySW1qMjlIVUlSdUEyMDhyQ3JQbmU0N0dkRGZ6bEV2YmIvdFc5?=
 =?utf-8?B?WnB3aUMyWlRjRTBPbnkyMzROWGgwWXlYSEJpNEgwVkd0Y1BldGE2NmdtNk1u?=
 =?utf-8?B?TEEwWHhjZnBOcEdRTnlkMGhuRlNwY3V3OWdIRHFSRG1CbGhHQ2ZHaStmd1Yz?=
 =?utf-8?B?dUlnQUtMYkxBdGFZbEZMM1BvVW42NEVjTTJvZDR1ODdBU2NEU1kvUEg1SkxH?=
 =?utf-8?B?VzBIclh0akxZV3hTTFRLbGp2cWhqVWo0aW1ML2hQQ2dWd0s0TnZIZW9nbTh5?=
 =?utf-8?B?elNIMlJzWDBOR3lBSldwZ0JVYlF1RWhHUmF4elpxYlhITnFjd1I4YXhwck5W?=
 =?utf-8?B?N1JDbDQ3L0JSUWE2c0Z4dWo3R3hBRmNGejNmc3djRW0zOWNONWZJY1N0MzdS?=
 =?utf-8?B?Wk5ObkFCZHVhL0pSa3JGelN6bVdiZnFqZHFkUGNoVTdibm1LR2pldjM1WW4r?=
 =?utf-8?B?ZnFSMzNzRkh5SlFOblllQjh4aU5kZVJkUXhOaVZLRmh6YXBMVHNJVmswV0dR?=
 =?utf-8?B?bHM0a2FNMXBpMnFrbnMrWkNQamFVbjAwTExYR1lGYlpRakE4OEh1aHNlNkda?=
 =?utf-8?B?RFpBUXdwcWRSdXZjQUdrMk5zTk9ERTdab3FZbnMrYWY1NG5XQVc0YnVKWmpY?=
 =?utf-8?B?RGRYNXRWMU1HNExma1dkc2tpcHc0QWtqQjZyajFlU24yTFBaZVpSMFdyRTls?=
 =?utf-8?B?eHZwRUFqWllkcUh2VTgwMHhaZTczL2tvcFRRcFowdTFPaXJ2T2phdmFEQ2ZU?=
 =?utf-8?B?OUt5QXRiSHZCcVpZN3NmWVlGY3A1TkNDQ3VFeC9aVVY2bGJzeDJZUUwyWlMv?=
 =?utf-8?B?KzZXK1pHWEh4S3p5eG9QbUZmT082bWYrNi85cVYyU1IyN0loQzMvMGJsZFRo?=
 =?utf-8?B?ZDlvVXVDMXpDK2x5QytqMmtGWUFrRlRiYTZCWlN0U2lsZGtjWHBabXdtME9F?=
 =?utf-8?Q?5jD8=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e735263-b6c9-429d-00cf-08dcdbd14d3d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 13:11:57.3702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxVvSE51lZp1Hpl8n5P0SPWCcKl0okodFI2c6Z/ysgzb9U69aoqoUjIHdwhn1Xzf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7217

Am 21.09.24 um 06:25 schrieb Dipendra Khadka:
> On Sat, 21 Sept 2024 at 00:43, Christian König <christian.koenig@amd.com> wrote:
>> Am 20.09.24 um 18:31 schrieb Dipendra Khadka:
>>> On Fri, 20 Sept 2024 at 16:01, Christian König <christian.koenig@amd.com> wrote:
>>>> Am 20.09.24 um 11:09 schrieb Dipendra Khadka:
>>>>> '''
>>>>> drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c:108:9: error: Null pointer dereference: fence [nullPointer]
>>>>>     return fence->timeline_name;
>>>>>            ^
>>>>> '''
>>>>>
>>>>> The method to_amdgpu_amdkfd_fence can return NULL incase of empty f
>>>>> or f->ops != &amdkfd_fence_ops.Hence, check has been added .
>>>>> If fence is null , then null is returned.
>>>> Well NAK, completely nonsense. Calling the function with a NULL fence is
>>>> illegal.
>>> Thanks for enlightening me .
>> Well sorry to be so direct, but what the heck did you tried to do here?
>>
> Hi Christian,
>
> cppcheck reported null pointer dereference in the line  " return
> fence->timeline_name;" in the function "static const char
> *amdkfd_fence_get_timeline_name(struct dma_fence *f)".
> In the function , we are getting the value of fence like this :
> "struct amdgpu_amdkfd_fence *fence = to_amdgpu_amdkfd_fence(f);"
>
> When I went through the function " to_amdgpu_amdkfd_fence" whose definition is :
> '''
> struct amdgpu_amdkfd_fence *to_amdgpu_amdkfd_fence(struct dma_fence *f)
> {
> struct amdgpu_amdkfd_fence *fence;
>
> if (!f)
> return NULL;
>
> fence = container_of(f, struct amdgpu_amdkfd_fence, base);
> if (f->ops == &amdkfd_fence_ops)
> return fence;
>
> return NULL;
> }
> '''
>
> Here, the function to_amdgpu_amdkfd_fence can return NULL when f is
> empty or f->ops != &amdkfd_fence_ops .So the fence in function
> "amdkfd_fence_get_timeline_name" can be NULL.
> Hence , I thought dereferencing NULL fence like "return
> fence->timeline_name" may result in the runtime crashing. So, I
> proposed this fix. Sorry, I was not aware about the behaviour of the
> fence.
> I am interested in the development and tried to fix this .

Well it's in general a good idea that you looked into this, but you 
should have put more thoughts into it.

That the fence can't be NULL is just implicit when you take a closer 
look at the code.

amdkfd_fence_get_timeline_name() is only called through the pointer in 
amdkfd_fence_ops. This makes the condition "f->ops == &amdkfd_fence_ops" 
always true inside the function.

The only other possibility is that the f parameter is NULL, but that in 
turn is impossible because the function is called like 
f->ops->get_timeline_name(f) and so the caller would have crashed even 
before entering the function.

And finally you didn't looked at the documentation. The kerneldoc for 
get_timeline_name clearly states that the callback is mandatory and 
therefore can't return NULL.

So to sum it up you suggested something which is not only unnecessary, 
but results in documented illegal behavior.

The C language unfortunately doesn't have the necessary annotation 
possibilities that a function can't return a NULL string (at least as 
far as I know). So cppcheck can't know any of this.

Please don't trust the automated tool to much and put a bit more time 
into patches like this.

Regards,
Christian.

>
>> I mean that is broken on so many different levels that I can't
>> understand why somebody is suggesting something like that.
>>
>> Regards,
>> Christian.
>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> Signed-off-by: Dipendra Khadka <kdipendra88@gmail.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c | 3 +++
>>>>>     1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
>>>>> index 1ef758ac5076..2313babcc944 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_fence.c
>>>>> @@ -105,6 +105,9 @@ static const char *amdkfd_fence_get_timeline_name(struct dma_fence *f)
>>>>>     {
>>>>>         struct amdgpu_amdkfd_fence *fence = to_amdgpu_amdkfd_fence(f);
>>>>>
>>>>> +     if (!fence)
>>>>> +             return NULL;
>>>>> +
>>>>>         return fence->timeline_name;
>>>>>     }
>>>>>
>>> Regards,
>>> Dipendra Khadka
> Regards,
> Dipendra Khadka


