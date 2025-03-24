Return-Path: <linux-kernel+bounces-573878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF42A6DD7F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 15:55:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59CEB3AFA9E
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 14:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F93025FA24;
	Mon, 24 Mar 2025 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aoIKSfYk"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7A725F987
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828099; cv=fail; b=VRQvm6ndjt8Xc4e7crcSfupLfmHERZpa0xVa6sK8YoxFq1SszB9bB6FQRNcy6PSzss9o/ctXBhEyrpa8S3ivUlfCJTTpswbev3++ud2+As0/Ezt47oObyc57c/f9sc82/lGwoCS+7NLYuamGJOsoTfCj2L0dT7Crfwo/AZHzhos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828099; c=relaxed/simple;
	bh=HuT3zb6/2P4sELVNzSDaif1BcAuDTv+dQ8p3rcBMXTw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=b6vfEkDtKsr/amVPswN4q/nGbtN8zAmqCy8wTuu1jAulavjRhFglRG9AfMCSUzujpwdXTqvcdexmvBsTTSP8iFRYVJvRju59gfzNiSLTpe9NDNkGAG8RWgJ9OWh07atH024vhw5tIVBKNtOailvP/8thMhjXEN2d3ywglE0dohc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aoIKSfYk; arc=fail smtp.client-ip=40.107.237.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GoaX+4K1ArRLnyD2VvM3A+dIbW+AnEpiYeOM51j4zwleVWMafKTnLQeQw1Ul3dQt2Hl+MS7eVq9JaA+T5N7N0r/uSj4a8UGF+zu9tTJQjej+jni4lnWYMYidD6mzw7ebglDhuxeIbw/YwI0PXPpTS7LnEuQzo75VlBjVLeNlBXo3NU9mXqr8DsimY2Bc5i9CSpZeCYdr9VjmGmrLc5AAKKXcIcz3Edd9oIalp7Y5wxhR/ec8h3/dc0Lmi5WI5LMoc1UqhoxXZJOtTtEj0A65jM10039Gy6n9NlMDOfaKQIYx8AuOkHygTimG4LTXGzuLACVmbNa+2LZSb0bZiOVGYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XMgn6b/EE0qpQZIH5dJaxg7EA8qLgYPqyyBZcDwlEX0=;
 b=H7qJpKMp26cAO+sHfRsbMg177VdrH3Dd71iMhh3OBUECVsQjYLX9YosdtZaK/XInWni/balWr0gdHWg6FMB4gahjBbKmonVyUald7CIajq/KDPGnqCs7nJnemmuloqgUoNTwo2W/RgbWr6LN7gUOGSE/DitkBORcS6P/UQjGsMQFpo4uNE2aEpSZ0SJll0git5ThqdqxBMugdJt91qyN9rqyu+GZQMLe2fRA6Dm3/Vl8mleAPH4Tw6tNA0LKjLLfxbE6dww66IWgTinjjdF3tDFSUh8x//6nwU0hP3XBT+M0CUCIOcWIRyNPyRS05aYPIPkXJf8rst90ITb/mZmhYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XMgn6b/EE0qpQZIH5dJaxg7EA8qLgYPqyyBZcDwlEX0=;
 b=aoIKSfYkVdGdjL438VBs+fJ6Gt/C8PyT75O5L5j/xmOHGsbx2MR9J5gwR2ipuyQPxBKHfDDeIggl2IkjkDzIFIAAVRMhG/LYunJAXr7fdKKT4qfL3nPL8U7yhUOPjeCgMABJVWXsXToq91cJ0wse0nX1+6ZqXd0Awgvj3LJpvSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by CH2PR12MB4070.namprd12.prod.outlook.com (2603:10b6:610:ae::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 14:54:55 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%3]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 14:54:55 +0000
Message-ID: <17b5d869-d1f7-4427-a293-aef42a37d639@amd.com>
Date: Mon, 24 Mar 2025 20:24:49 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH V1 09/13] mm: Add heuristic to calculate target node
To: Hillf Danton <hdanton@sina.com>
Cc: dave.hansen@intel.com, david@redhat.com, hannes@cmpxchg.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, ziy@nvidia.com
References: <20250319193028.29514-1-raghavendra.kt@amd.com>
 <20250321105309.3521-1-hdanton@sina.com>
 <20250324110543.3599-1-hdanton@sina.com>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20250324110543.3599-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:3:17::14) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|CH2PR12MB4070:EE_
X-MS-Office365-Filtering-Correlation-Id: e25d5b4c-b4e8-4fe3-848d-08dd6ae3d6b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M2dUdk5TOHhqOEUrek5rWXFpb2JpNjdHQklKUlQwejZSSEthTW1RclNFdGxy?=
 =?utf-8?B?REEzSVk4SW9ZLy9SdlNBdnJQK1dIVXNHcjF3YTZwZUpXQ1VkbkJpR29KUzRv?=
 =?utf-8?B?c2pOWUdWd3ZKbSs3Um9YUWpBbnMvMWF0VmxKRmNwUXV3VEZkQVB0VWs4WWN0?=
 =?utf-8?B?VWJSd2VQNUJjOXVpTi9JaGU2OHlXaEwyQTVrLy96TVlKV2FnTzczNy82M2o5?=
 =?utf-8?B?czRMRFNFVkZYZ1ZlTWI0TFhZSWZBdkZqWkM1USt2VVNaM2JSTG52cWRVTGs4?=
 =?utf-8?B?RWgxVWNicmJZUFBURHEyaVV1VVNESzVxdDAxWFg2cUt6SDk0elFVUnRCSEdh?=
 =?utf-8?B?M3BxazNKb0lpS09qcG4yWGFaU2gyazFiNWFDbFZkV3pwS0VIVXErUEdhdTZw?=
 =?utf-8?B?allTWmpMVEVIWU90Wm55Ump5U055UU5lc0N6QnEzYVZsemlKalJKUGZibGNC?=
 =?utf-8?B?RFNVUTJURzgybncwZ3pXMzk2TWVXUkwvc00vOWtjd1lWemw1bDJIUExSUnc2?=
 =?utf-8?B?QThVN0x3SUJob3RZTFYzaUFXbFhjdW5TakxxRUpNcFVaSThldGNtbFUxZlNU?=
 =?utf-8?B?alNNaHpUd2pLc0xReEFLeVd0N3crdUVtU1Z4Ti9QcWRubzVuRE1CTUZodVVB?=
 =?utf-8?B?cnpMQ0d2TnFxYnJNVW5nOTh6N3k2cEM3OStTaFF6TXVPd1JZMXp4ekF2N0Z1?=
 =?utf-8?B?L3dGR2tmOVZkMnNjL0p4TndUWGJHRlhGaUtkQTlKakxqSGp0dnN0WGg1TFIy?=
 =?utf-8?B?VzhDYUQycStaVFVuWXVKSTRuaXk1T080OFJLdmI2T2krcVVZbGM2SnlTdEFl?=
 =?utf-8?B?R2pwcU9IczZnbllEczZlaHRVSW5vZ2g0VVNNSXdiTmg4ZnNKUm5sZjBhZUIr?=
 =?utf-8?B?NkZrb21WR3l2NDF6Z3JYS25qbFRwNnJUS0hZdVJZWDhKNy9ET1ZWaUhHQjho?=
 =?utf-8?B?aHBqakhRR3l1ZEJuck1hVnh6Qm10NkNINHdSZEc2QVBXZlNmbGtqVXVWUVJ2?=
 =?utf-8?B?bnJyMWFOWGxjUlJXcnNOKy8wbGZJQW9ONHJZbU0rMk9TNzNDRjVaQjVWclBt?=
 =?utf-8?B?YXJ1QVVLTUUwQm42dGRueUhORnpWR1BLNEFEN2NGNnVBck96Vjk1dWdLOUpR?=
 =?utf-8?B?RlpPTGx0WlFRY2NmOUJvS3JYZzFZemZRYjZXMHVRa2FVOWRBSENZMis2aDJm?=
 =?utf-8?B?bmhFZXVvd3k0c01BY28zRFU1Y1FWT0FMWEUxcnVOaStRZ1RMdUdETERrM3BR?=
 =?utf-8?B?RFQ5T09LTFkrT2daQ2xZME1XeFpHY3ZleWpaTERDWDlrSzAzaTgyNktMVnZy?=
 =?utf-8?B?Y3FkYndJR3owS2huWkc5Y3JvY1NpVG9RYklpQ2VHQ3pVZWcyUm1KTWdnZEVI?=
 =?utf-8?B?eGFEc0Y3K09MVDhYSGE2K1JKRlNKclNjT1h2L0dZNERwU1VuekJHZUsrdlZ0?=
 =?utf-8?B?bFFEdEg5T2NUNVhQZ2Nmb3FhcHFvVHluZzdORjJpa3p6a1ZYMEpTSExDTTM0?=
 =?utf-8?B?SUFrYnJ3YXZ5VktDRnpidGR5cWFTc2lQQ0VFcGVaL0ltSU4reFJValdha3Yr?=
 =?utf-8?B?WjROWnlrMXNCMmdzQ1RNekZyUE1qZ21KNjBBaXJpdER4clcyQjJoTVY5dE1p?=
 =?utf-8?B?M1VsQlk1U3ZMUEFaNEJFTjNTemVVY1k0OWt5MDR5L0hxVXpROWdHTjk0dlFn?=
 =?utf-8?B?ZGR4RXpsRW1FVjVITnIwYm1oWjBwbSs1UklRN213ZlBWNE1MYnVpYlZpdkVK?=
 =?utf-8?B?Mm9rT25kVUFURVg0Z2NYOVpXS0kzSmJXNDRzREVWbVQ1RFFaQ1ArdnR1MWRy?=
 =?utf-8?B?cGRoYXFsMFRPOXpSUFJQTzlQTlhxM2g0bFFZKzR1Z3BxYzg3eXU2NG12SlhU?=
 =?utf-8?B?cGxrc1RMRmFrYnUzVEVtUytnMTFOZk1VNHZyNWx4S3BSVTFvb0RrQUpQdFVX?=
 =?utf-8?Q?SRvn9SKcSy8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnlYQzN0dXJFbG5tTGVvVnMycXdLenFYbzJMM0trMWpGeldGazBOcnFxNnI0?=
 =?utf-8?B?NXY4Ty8vWmtuRUVpUkNsbStRazFUeUp5aFk5bzZyQWh1QzVPLzBpbmNVejk0?=
 =?utf-8?B?NmJ0aEdMdlJZWWIvRHRDYk01NmpxeUFCYUwwTlllSUY0T1FnUWFXbEFLNnE2?=
 =?utf-8?B?V0NxT3V3dDA4QnVKQ0luWXQ1cmlXNzRxUlFGNlFNM1ZGSjVrZmtBOG53N3ow?=
 =?utf-8?B?TE9XY1BhV0FkZ000bFZrQzVibUFxY0VrRk5IVEoxM1l1ZFNpU1Z2M1YyRDAr?=
 =?utf-8?B?WFpxNVN2NWNaZ1ExS3ZiaS9tSUlxOUZUMXFvSTNiOWVLd2xnTlJZdDltZFdZ?=
 =?utf-8?B?L0hFZ25DV1hTUE1vejhRN0VLQ3JKRVpEemluUE02TnNmVlhZS3B0bkM2UWZR?=
 =?utf-8?B?dFNiUkxFSGRwNzRKNlB2UTVmUUZQUUFVblExRmNmWE93bmJ6WldUVHB2Szhi?=
 =?utf-8?B?MlNFQyszN0thbXlFemg1QUJkaVVsZ29QUTQxUTJwTVp1Y3hmV1BxYzZzL05z?=
 =?utf-8?B?cmg2TGw5bEFycUhtS1Q3bkxYUFJFTnlWc1gvanZBaWlORlk5UUVSRys1UGdn?=
 =?utf-8?B?VmNuRC9OSTZXbytaVlFUckdZcTIvREIvR0laZDNvV0prVEZpRjlKUG1pRElC?=
 =?utf-8?B?VmpBRkw1SklPUHkyaVBhbDJJQ1dwZytWQS84WTlqNjBvVXo3TlpBbDVhWlVl?=
 =?utf-8?B?eWllZ0JGT3dsUDhqVlNhMUxqMTRyS2pRU0c3djZ0azdEMFNvdXFKNHhWK1FS?=
 =?utf-8?B?Q1k4VEdkRm5kT3hmUUhxTGdCZHRQQzkyMS9mays3OWYweUJGRzNkK1lnN3g0?=
 =?utf-8?B?SzhmU2YvSmRDam1EYmFBMUZjZitiVHc0ZWhMM3ZaTXZYS1dWNlBQdS9EZC91?=
 =?utf-8?B?T3JWR2NaS3NPTkVwSEwrT1QxelBNSU03RkhJS2JUS0o5Q1dWT0JOYi9KVVR2?=
 =?utf-8?B?K3BoOGk1bXoyVHorbHNPTmNJRzhNYng3WGxHQkpFMEtFU2lWdVRzRjBQU3NT?=
 =?utf-8?B?MEtJVHQrTWUyekZGdWF3ampucnVPVzJhb1RQY04xWW05KzRydFFYR2FVRUFU?=
 =?utf-8?B?bldWWWd4UzIzNXdCSDNCdWYrYXZGR3ZwendJTVRVekI0bzdaTVBObmtETkVq?=
 =?utf-8?B?OWc4a3JzSU5SdDhGY2FNWjN1bHZOZHRwbWpKak5ZblU2SFZMUDNOTXJiWEM2?=
 =?utf-8?B?c3QxTWdRaEVleGd5a2h0WTdNcTdZWXJHWnFkQVgwTElRRHhiSWc0QlgvZDcy?=
 =?utf-8?B?elNkRktGYURlQ0phNUpIN1pXZnN1YmZCTE16aDZobjByc2tFZUwrUUo2amVy?=
 =?utf-8?B?cEFYUWVubHg5MVpVOFpMcW1TMFJDWGNtV04yaDRrTzVsSldITE80UHh3bmFF?=
 =?utf-8?B?S2syZVl3K3Jlc1h1MkluaVNYTjBsWCtNd2NLQXZtM21MRW9MSDdYZEd4TXNO?=
 =?utf-8?B?Ri9OUDB0dk4vSy82ZGFPWmtCejNxNHFtZHFPYTh4MnNnRUJIWGlCYUE4aHEr?=
 =?utf-8?B?cHlnUDNlR1J5RzdOZmRnUW53bThtVCtEaGZydWNWbERGWUJKS04vS1Rxa25T?=
 =?utf-8?B?OXlpTkpCbk1NVGI0ZG5QR0hFNy96S0g4Z0JMS0x1TlJ1THliOWVpdHBjeEFV?=
 =?utf-8?B?YXhzSkp2cllOc1ZoRWpIeWdaM2tDUnB6QllJK1haRU03Z2xKejRMZG12dHVi?=
 =?utf-8?B?VVlaQ1pQWFhXUzhpQXJOK0d3bFlYaVZDMG9ibmFjT1NqcThsU3FXK0NTTCtP?=
 =?utf-8?B?R1A0V0dEY3BTYUI4Y25lV3BKbm41ZXozdjVxeTdYWmtFN1JkalJ2RWRqNmlG?=
 =?utf-8?B?ck1nanF2aWh2YWVzQkdTNnFpNUF0blduRUY1Syt2K3BDYXVPUUVHN2N0bWZE?=
 =?utf-8?B?S1pRcDYwTkYyLzdUU2pNQlNoRnZIcGNuNitqbWJzcFRpWENlaUhXNERmNElW?=
 =?utf-8?B?MnpKQTR6SHF4Vi9DcnZWYXF4S3c4Q3J3cXVpdlJoSHVid3laZVBhVHE1VFRn?=
 =?utf-8?B?L1d4OUJSaTZyNW9FMzFEY3ZBVzdmUUgrTVhrVndlWWtBVDZxMXlOQUxiL3M4?=
 =?utf-8?B?WmpQMTNoK3Bxbk1sSTVPRkFubm0rdE8wczFERXpsTU9WV29rNEs5Ynpod01o?=
 =?utf-8?Q?QW4tyXTufmEtZIpTNvHSlvLXF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e25d5b4c-b4e8-4fe3-848d-08dd6ae3d6b8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 14:54:55.2114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hJQ9D37Kt+JCicOpqWvmO//7+HMh+P288K1gcyPvkD7nAlwgPQueMKqn6z2ZqXalFLB2uT/cSxZlx6LSs4IzUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4070



On 3/24/2025 4:35 PM, Hillf Danton wrote:
> On Sun, 23 Mar 2025 23:44:02 +0530 Raghavendra K T wrote
>> On 3/21/2025 4:23 PM, Hillf Danton wrote:
>>> On Wed, 19 Mar 2025 19:30:24 +0000 Raghavendra K T wrote
>>>> One of the key challenges in PTE A bit based scanning is to find right
>>>> target node to promote to.
>>>>
>>>> Here is a simple heuristic based approach:
>>>>      While scanning pages of any mm we also scan toptier pages that belong
>>>> to that mm. We get an insight on the distribution of pages that potentially
>>>> belonging to particular toptier node and also its recent access.
>>>>
>>>> Current logic walks all the toptier node, and picks the one with highest
>>>> accesses.
>>>>
>>> My $.02 for selecting promotion target node given a simple multi tier system.
>>>
>>> 	Tk /* top Tierk (k > 0) has K (K > 0) nodes */
>>> 	...
>>> 	Tj /* Tierj (j > 0) has J (J > 0) nodes */
>>> 	...
>>> 	T0 /* bottom Tier0 has O (O > 0) nodes */
>>>
>>> Unless config comes from user space (sysfs window for example should be opened),
>>>
>>> 1, adopt the data flow pattern of L3 cache <--> DRAM <--> SSD, to only
>>> select Tj+1 when promoting pages in Tj.
>>>
>>
>> Hello Hillf ,
>> Thanks for giving a thought on this. This looks to be good idea in
>> general. Mostly be able to implement with reverse of preferred demotion
>> target?
>>
>> Thinking loud, Can there be exception cases similar to non-temporal copy
>> operations, where we don't want to pollute cache?
>> I mean cases we don't want to hop via middle tier node..?
>>
> Given page cache, direct IO and coherent DMA have their roles to play.
>

Agree.

>>> 2, select the node in Tj+1 that has the most free pages for promotion
>>> by default.
>>
>> Not sure if this is productive always.
>>
> Trying to cure all pains with ONE pill wastes minutes I think.
> 

Very much true.

> To achive reliable high order pages, page allocator can not work well in
> combination with kswapd and kcompactd without clear boundaries drawn in
> between the tree parties for example.
> 
>> for e.g.
>> node 0-1 toptier (100GB)
>> node2 slowtier
>>
>> suppose a workload (that occupies 80GB in total) running on CPU of node1
>> where 40GB is already in node1 rest of 40GB is in node2.
>>
>> Now it is preferred to consolidate workload on node1 when slowtier
>> data becomes hot?
>>
> Yes and no (say, a couple seconds later mm pressure rises in node0).
> 
> In case of yes, I would like to turn on autonuma in the toptier instead
> without bothering to select the target node. You see a line is drawn
> between autonma and slowtier promotion now.

Yes, the goal has been slow tier promotion without much overhead to the
system + co-cooperatively work with NUMAB1 for top-tier balancing.
(for e.g., providing hints of hot VMAs).




