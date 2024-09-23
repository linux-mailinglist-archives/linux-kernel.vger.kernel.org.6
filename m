Return-Path: <linux-kernel+bounces-335773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE76697EA76
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 13:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 777C91F21D4B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 11:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4498197A97;
	Mon, 23 Sep 2024 11:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gvOzlmci"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5126219645C
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 11:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727089663; cv=fail; b=ORykqxZnf8fmtzMi8sq+eirGQn3gpWUjWX/OOuXrK/VaAxKt4Qj33KjjFaDJDdeMSHzstT2qrR4hrvGeLfsl29uTKwsIWyb3SZYvguhPy9f+sFU0XpBWTMFRi9cs34Dey8dJUxLsq5OO++TYXbl6rmIzyS2EpcpYz1ApIsoOUjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727089663; c=relaxed/simple;
	bh=s5YqE4OR5Kd8brTDt9dStERA6JrxG9afVJPUGMFIEVg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=rdFTtREe4Lebk3g03MlqVNDnzm7L+Dkk1CmpHoezliEh3bbvxEddretDifEoVd+gQIhvfY2H/b5Fi8GBL0cbOCi8J6Q5mmjEUmtKnyHERBaLxx8MeRGIAW7ByrcgOGwQxGEk2WF4l7lB8xXlYYX4EyQKjQwrraGMHB4jouHny/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gvOzlmci; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F3/3l1ihChV5aTnKDw/AIDUb0eUiA2go6YCKLjBbrTnBQYjgAH7MJBnui42lx8GYyozTuKEu2WUUf9F8vtUGTH93ccFKoP8qXWS3CwKSgqWWiXGJwwo5hu7QtiFKJSXUUTfUCqUm2lpVE0M529I7vWLnzDYNilwqWsrROKDto8U1Wwg9UyRUpvHEuqGzr0jrfZZyNdVVkXEZrk+l72dwBkAnJYu09WpFdKQs+FA7X3GsWIGLnlON0oafp6T+al9vLlYGRvo8U3xEf0+dwWIKHVoSCJiFD/fxJSgXomDoI/CJEt3XAnN2j+iqlfnRNHSiy5X+GXnWnzPPHXzjkhLQlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiffBXm3FmnhVUg6m8JjTUVQmORue31ZLQVrDh7myBc=;
 b=lbCL6XXustsdANmueuY5AJV32YNjqqibwEaX4SioeBZW9DU/tshaOx2Dsj5bOT1z9tPnlbiBcGMU/IKOyQrP1I4bfUPZhaYsharIzMKVq/MR0lVVKybdgDwmF868vin6q/x3aFusau/JdkygSx6MjHEaztjT6hIA4TbXbq08nAiyhRCTus9MnW4GEffppGgIajF6HJx7VfAB7BvtwVGpO0cyOOGPu1cWujxT1xmYsr/hRMZe/6RpxEVkmQzFVxPuLt/+ZriOWFgcsXARfo5roRdyrEAH6Cpf+CJVM+s+nZb4O9sTlQRtjbv1VM+6rxOVH6+ak6kTTvgxbdA7FJOxJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiffBXm3FmnhVUg6m8JjTUVQmORue31ZLQVrDh7myBc=;
 b=gvOzlmciBBJDPl9EAspCezYNbH7Cc2qaynxs800eJWZQnUAlillWjponasHlIysNY1QaUr9CnRmlytsjuCBejCMS38/k4SfySLnHW/8x7PVU2GU+aqXtmKSipONWImuJRlsM2IcikwoSZXQxiDYkfKo4x5+ZOgEEIV8t9QqMvpU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5346.namprd12.prod.outlook.com (2603:10b6:610:d5::24)
 by CH3PR12MB7620.namprd12.prod.outlook.com (2603:10b6:610:150::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Mon, 23 Sep
 2024 11:07:39 +0000
Received: from CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::235b:4524:308d:ec90]) by CH0PR12MB5346.namprd12.prod.outlook.com
 ([fe80::235b:4524:308d:ec90%5]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 11:07:39 +0000
Subject: Re: [PATCH v1 1/1] tee: amdtee: Use %pUl printk() format specifier to
 print GUIDs
To: Jerome Forissier <jerome.forissier@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
 op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
References: <20240911204136.2887858-1-andriy.shevchenko@linux.intel.com>
 <CAHUa44G4O0JgqN=BwvshRXzUeEE1oXD1o8Yn-5X6p5qY8vkDQA@mail.gmail.com>
 <ZuQF_w7G1A90tYG3@smile.fi.intel.com>
 <5c95cbc6-48b6-9cf4-8682-fc6469cb9c81@amd.com>
 <Zuf8fw1MM0jaisUh@smile.fi.intel.com>
 <94e37138-ae66-4336-93ac-79683f2058aa@linaro.org>
From: Rijo Thomas <Rijo-john.Thomas@amd.com>
Message-ID: <78a3361f-2223-498e-1ee9-644998e55d6e@amd.com>
Date: Mon, 23 Sep 2024 16:37:30 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
In-Reply-To: <94e37138-ae66-4336-93ac-79683f2058aa@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0014.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:25::19) To CH0PR12MB5346.namprd12.prod.outlook.com
 (2603:10b6:610:d5::24)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5346:EE_|CH3PR12MB7620:EE_
X-MS-Office365-Filtering-Correlation-Id: e04caa6f-dc22-42e9-c864-08dcdbbfefc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWt5K3NqVS9CNVdnL012K3J2R0FwTTVhdWRnMW9CUXJITlRoMk0zR1FmeDhO?=
 =?utf-8?B?YXQzYW1XTER6VHhEdDJTMTV2RHFEa2lFSFVITzRNVUtrblJrMS9ocExnbTlo?=
 =?utf-8?B?a3h6SlNoUXpOUzRnUGo0TEtneXQ1aXMrUVIzRzVFMXljYUoyRUlkT05aTCsz?=
 =?utf-8?B?YjBWNlJ2SW9xdlFGZGMzdWQ4aEprM1huaVdsUExwMDZRMEpDUDkwa0R6Q2xR?=
 =?utf-8?B?elBINGdzMnUySnI2L3ZNNmQ2MjhwaGVKT3BkakJpUnRWcmlBYmVBWjd3WHhF?=
 =?utf-8?B?TjNlelppSU5Eb2laZytSVVhmRkFHWkFnamhqemt4eG9raEVmbkMzaGRVQmNX?=
 =?utf-8?B?WlJhTVJQbzRVWVZpN2VSdmM5eUZhRWl4MWJIOHg4UzNYZk9pODNxaUI3bWt1?=
 =?utf-8?B?V1FpaDdmQUM0eUIrM1hxRXpQMXc3V2Z2UzJBOHNNNGgwNS9tWVBrc3hKWDJa?=
 =?utf-8?B?Njh1VlY1UmxXcjZPN0piM1RyUG5pOFVubG5mU1lBUHJTZzdKd29pWFJaWU9B?=
 =?utf-8?B?cm05ZVQ5OHVIUGZ0YUJ0cmpkL3lodC9jamN3UzR4NXArN1kyUGRKTU9CT0FS?=
 =?utf-8?B?bXRiZGJORmpCWlkySHNCMWZManFtZmdMWS9hcUMzKzhaZVVpNTNOZEY1N1Zv?=
 =?utf-8?B?b0ZwQTNtcXl6S1hzS0daMTRqbS84MVFkbDhnaW02aWVJWTdJd0Yrdklabi8r?=
 =?utf-8?B?Yno1V2lyZ1A5TVpjSzRpeGhWUXJvOUJoNTJDUUhDanQ0aG9BcWxxdGJkaUVU?=
 =?utf-8?B?OGVuUkxoOGEvbXpjYnVYMjFuZitKOWc0VnBPbWdTMXd6bHdreWdicUFKVThv?=
 =?utf-8?B?WUE1Q21IcWs1Qldsb2t2UUNzV2VpeUVIcmoxYlVKRGZ2azQ5WTRKekJvTjkw?=
 =?utf-8?B?WnZGLzc5OVFhSmpicWhhbHE4bExWZlVJUVdEZmhjM011RTJlZGd6czRnK1du?=
 =?utf-8?B?RTVEWDFlem4rdUlaTDZpSWwwakM3Nkhzb2xQY1BoS3hUTmtScTh0eDNjbWFm?=
 =?utf-8?B?Ym5OVHhXSVFJZisrWXQwT3BUc243czRPS2QyV1RlbFdkQzZMaUU5bzJMN1lP?=
 =?utf-8?B?bTRQWU1KUDdzREcwd2JMbmc0TDNpWURDUTVNUElFSVhuUzQrNW5Cc2xKemkz?=
 =?utf-8?B?RURVZ3hvTmlyRkFiLzNlc1lkVWt2eE9rakp4ZWNYclg1b3g0eWlvdk5xM3Nh?=
 =?utf-8?B?NDB6OGxhWFpZbFJzb0FDVW5weW4rdDF6TWdreE80VCt2OWdab3RqbUJoNnNR?=
 =?utf-8?B?dkZReSt5eWRkUW0zdmN5UTVXR25PZHFjTEY0VU5SK0Z3WlZFcThYbXhhekYv?=
 =?utf-8?B?MVRhZnNvWXZuVzRqaXJ3akF4VkIwRDBSZTg2TVdSTkRRVlNmejIwT1hDTTRS?=
 =?utf-8?B?N0lPbEYxZDNWUTZvRVFiRHdFN08yc0pyTUxIYkhzNURqZGlVRkhYOHNNUDRq?=
 =?utf-8?B?OGJmZFlBYkV6Q1NoRHllVGNoQXo0bnF0MUhWSUxFc2RwdnR6WENyREMyWXNJ?=
 =?utf-8?B?UTdvOFdkam5aalRXWnRqZWVKVkR2STkxOGwyd3NybDIrVVpJS0FmNW44Q1Zz?=
 =?utf-8?B?VllrRkVtZDgrbjU3d0pZSldLb0hGNzVPeFNFdUVKcGRGRlMwOXZnYlZ1c2VF?=
 =?utf-8?Q?G1ker71NazQofN3khAZ5s9TBrH0WZhDjaVc/v+CTYpdY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR12MB5346.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blJVanFROHJaYWFHTUpibk1WaVZyOFBVWlZVRzhYTkRROTBHSlMwK1dZRWh3?=
 =?utf-8?B?VTRia0FTeGQ3R0JCak1TMHNScnlrS3Ftakt4TjB2NXpuZzd4NWlzZjRudkN5?=
 =?utf-8?B?M1BLdTBON083QmlONHQ3aGNvS1IrUC9RVlZYbjhqY0RKVllCY3UrTlh3eVRV?=
 =?utf-8?B?LzZZdlZUNE8xeSswVUdxRnRnV1k3a2VJUFB2cnVvcVJUV3BQNk9GZmVZWVpv?=
 =?utf-8?B?alY3ZXpaK29OQ0lrMERPaEdDLzFsZ012WE1JaE5NbithSERYODVPVTBIc0FD?=
 =?utf-8?B?aW5YSEx2TEd5UGJMaWVqb1JwWlIvN3N4MDYyT2Vjb1RXdG5ySTdVY3BNdGJt?=
 =?utf-8?B?UjR5eUt2QlBxSEM3OXgvVm5iUU93emxHempqek5uOXRpclpBaStmYVR2MkpD?=
 =?utf-8?B?YUF6MW5uWFVFM3hpTWZGdGtrNWdYMlhoRVdGZ3I1cmN3VkZoQ1pxYWp2Y1Ft?=
 =?utf-8?B?eGxaK3RDM0cwVjR1eGthRGRBaURLTFFTV2cyR2tOc2tPYzFtQk1lbUk0L0Yx?=
 =?utf-8?B?ekxMMVMvOFRzWWJYZTFjcnNqSW5DUDBSSHR1bWp6WVhOS295SEwvbEp5cG4v?=
 =?utf-8?B?UW5mM1VzY2RXT1lxL2tKZHhjTjZ4VWxnMzkvOC9jSGVtUHRoWS93TTI4Wkd1?=
 =?utf-8?B?VHhPWXU4bkd0U0dhWngxQUNoeDM1QkdPRC9YZCtxWjQ0QXRUaXMvYkVZMjFY?=
 =?utf-8?B?V2xqUDNrQWtaNFM4SnNkRVN1TzdBYk1iUVp3ajA1bEN2R0xkRkMramwwenc1?=
 =?utf-8?B?QmV1YTg5MkhhSTBYd2ZJZDR4WDVKSTNNMVZBT1BBbU1xK2RXcTFvb1EwT1Ru?=
 =?utf-8?B?Y2VNY2dsQWNjd2ZvMFl3b2k2ZzdVQWM5MUJrd2RVTEIzSlp2WVp4U091eE5C?=
 =?utf-8?B?UUF0UGdCeHNHbmt4dDhGdGdxczByZi9abldtTlh6RnhMdVo4VEQ3RjFVNTE5?=
 =?utf-8?B?QjJFZ2wxa0VkWVVsZko0ek9iWGs2Y21zOUh0RnJ3QlR0aVp4U1RObXFHN2RP?=
 =?utf-8?B?cmxTYjFldE5VRUpIMTV5bFh0TTcrZHhkUzRnaDI0SGRqWEFKYmZCM2FaQVBw?=
 =?utf-8?B?dXdEZmhlbWM0aU1RTGp1S2d5UEhRa3BqSnZYeHhHbzFoMFJXV09PeE80NGpI?=
 =?utf-8?B?bHBiL2d1UGdEMnM3eXV3T01YRE9zZlBGekxwcWRPRW0wQ2ZJNDJoeHdBTHZl?=
 =?utf-8?B?eHlSR1N3d2NIYmRjTk5kZ1lYQ08rT2ZpS2ptdWJDdUtOdytqdDE4M044RURD?=
 =?utf-8?B?UUJ3RG9lTjBualJRcjdRRTd6emJJTDRGNTZsSW5qUFNpUlBSK2R4VW4zVXM5?=
 =?utf-8?B?eklvbTFtN1NjWEgxdUgzdGFlRU5IcGNOeUcrb1NEdTJUNDZrbFBobGJuNWlF?=
 =?utf-8?B?S1hsWEJpd3VkcEJkZjlTSGQ3R1NnOGU4eWRTeHNBZTZVNHcwcXZmN1pzTVEr?=
 =?utf-8?B?cDBONWUwdWkrc2R1UFB6Ymx2YzJYU09qTGFOQnpBdU5yOHk4NkxMd0pPUTVl?=
 =?utf-8?B?emxSUm1zanY3RGl2NGd6dS9aT283dkJrZkxtNlR3N1NLVGRjdUJqL004YVpE?=
 =?utf-8?B?YlpnamN2ZitsMkgxZGxqL2hMUTZLZDVCcE8zQzh6c3JqT1ZHdFE2V3NHdWE4?=
 =?utf-8?B?aGJwajlPRHdVUWdzTlIxRWZPa3VZL0xIMnBrY1B0MUl6MlM1RW1TS0VUOHYw?=
 =?utf-8?B?b3hKQmZtSjFMVHg2MElkK3pybkMvNGdCOHpjTmhvZ2V4ajdlTnJEUTd1anVD?=
 =?utf-8?B?dkRXM0k4blU1c0hRazBTQkxSaDdQWEIrVkw0R1QvUjVvU0hPMy9lMWRxZmky?=
 =?utf-8?B?V1ZDeGdFV2F4SXZQc3lLcWxtU0JHaVhLbzQzSlNIYm9BblpLaUgvckFRTzI1?=
 =?utf-8?B?MzBiTWFFbGUzYnFKRlpIZUxoT0Jab3RldTlYOEVKeDI3Vkp0cTc2NElCTGNl?=
 =?utf-8?B?T2tkcWl4S0xxSTJnNjJsUElza0x0My9jYzhsbUxJaFNOUHBFTkVhU3VDQk9a?=
 =?utf-8?B?TFpqUjR5L242b2VqUXIxaGxBSTlKNDcvSWV1cXhMbkpYaHdaU0hvYkVsVWpB?=
 =?utf-8?B?UjZ1clAxWUNZZCtURENXeHNBc3dtR3ZycUV5aWpVWThxYmtCQVM2ZHd5Y0xG?=
 =?utf-8?Q?0Jbk97QCM2OcFs7AX4NjKJDnM?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04caa6f-dc22-42e9-c864-08dcdbbfefc8
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5346.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 11:07:39.2709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8REI9RUBq0ERKisQ7Ep7kPgPLdXOJK3KK9e2ZurhlZTgsUX9ebISu5AvTQEhG5UQXM5W66IhyhjIfy3WK4FO9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7620

On 9/17/2024 12:52 PM, Jerome Forissier wrote:
> 
> 
> On 9/16/24 11:38, Andy Shevchenko wrote:
>> On Mon, Sep 16, 2024 at 01:38:27PM +0530, Rijo Thomas wrote:
>>> On 9/13/2024 2:59 PM, Andy Shevchenko wrote:
>>>> On Thu, Sep 12, 2024 at 07:50:08AM +0200, Jens Wiklander wrote:
>>>>> On Wed, Sep 11, 2024 at 10:41 PM Andy Shevchenko
>>>>> <andriy.shevchenko@linux.intel.com> wrote:
>>>>>>
>>>>>> Replace the custom approach with the %pUl printk() format specifier.
>>>>>> No functional change intended.
>>>>
>>>>> Thanks, the patch looks like a nice simplificatrion.
>>>>
>>>> Thank you for the review.
>>>>
>>>>> Rijo, Devaraj, does this work for you?
>>>>
>>>> Yes, please test, because seems others use uuid_t (UUID BE) for TEE,
>>>> but in this driver IIUC it's guid_t (UUID LE).
>>>
>>> No, this does not work for us. I tested this patch, it does not work as expected.
>>>
>>> %pUl gives output in uuid format (%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x).
>>> But, what we need, is a name with the format %08x-%04x-%04x-%02x%02x%02x%02x%02x%02x%02x%02x.
>>>
>>> Endian-ness is not an issue here. uuid generates name with 4 hypens (-).
>>> While, in our TA naming we are using 3 hyphens (-).
>>
>> Ah, good catch! Can somebody add a comment there to explain that this uses
>> non-standard human-readable representation of GUID/UUID?
> 
> Could this be due to some copying/pasting from the OP-TEE code base which had
> a similar mistake prior to v2.3.0 [1][2][3]?
> 
> [1] https://github.com/OP-TEE/optee_os/blob/2.3.0/CHANGELOG.md?plain=1#L40-L45
> [2] https://github.com/OP-TEE/optee_client/commit/a5b1ffcd26e3
> [3] https://github.com/OP-TEE/optee_client/commit/365657667f89
> 
>>
>> P.S. Thank you for testing!
>>
> 
> Regards,
> 
Thanks Jerome for the information. We will update and post a patch for this.

Regards,
Rijo

