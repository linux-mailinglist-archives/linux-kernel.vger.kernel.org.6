Return-Path: <linux-kernel+bounces-370378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 193A89A2BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 20:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F151C215A6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2024 18:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929E31DFE31;
	Thu, 17 Oct 2024 18:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VoCAey1J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YPAi6lVq"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8858D1DEFF3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2024 18:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729188472; cv=fail; b=QhgoXs/5WkkzmbWuqeglMtpBSeLh208o+KZ4cjevYImJCifETJLbtUXTpKZJzQEh08UKC0qyo4iCc2LRRIbWUxmhtxdXngnDqRJfWtFleLPfzde8zfQHIliRugfIuSMNStM9+6npk6Gnt2v5OuT0vt3AngnzcPehrrVHmZbb1uI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729188472; c=relaxed/simple;
	bh=nTNMl7ynRnplol31hFu4SbP/DiMeaqJBqYAJJ4BjtPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LxuOz40yV30LOoVgXk1TZexklc8BwB0edKAFm85xBEzfx0UQKySZ2wMtOi+u0l5PH2FjFkxvnJFM6W68qIVSk73x6cDPsFwV1xQyb6XpVJ8phftH7EA+YM8JrVcq2/vd3kkziYz6YoCGcpCf7N8k3AIaMbNkLeU8VS6ukodZYE8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VoCAey1J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YPAi6lVq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBujf017817;
	Thu, 17 Oct 2024 18:07:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=y25Qfe2jK5hcBJs1KdpbxrYDsyn+tQcQBbVt7LRR6dE=; b=
	VoCAey1JG5PKGA2S1ED9Y3+AMVbpTiT5Ictso+luCPAliqi9Qlt1RjZj+IL7Savh
	rpk8CBtx8heaUrFMYpWsdCosLHEknoZYwtxXkpFcBpo/2EO3RoRMDDVIqF01OX/e
	W3+GXy7NRuQv7h3/rMAo530vkvxIvm6QuNS2wZjbDcjdZWqt3LmAkWWaEf2lj2mC
	14/zExzRGhUSJ9+tipwl4/bnmcRb5bF/8sMcMky9ohRB4EGedewA5CUAB74HBrx6
	E7wAI7DH1kHLtRRRFC0U1Hac7VKGffBXTlv+UMIJG/9rZW3L4bnz8k63upRz6/U5
	YNkm7/7RyiOzVMK7MxBNAw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hntf42w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 18:07:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HGcb0I020037;
	Thu, 17 Oct 2024 18:07:25 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjakn2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 18:07:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZW26Vi7+3Ok7nFtOMwZ80X+VykMi6llnCU7Oo0OkxCN5Ih8zPJFf8tvn5xe3WCYzviZFYoXLUoDa4gyAt2GaoRQciC8X6oQUvTP7+uS1/Wot/YOXmXr4RlzZqmVrFT/YywF7jFxjyWzqAIOug5whYk4jOd1wApFmyMOHIAtq29qWMFsvl+lFJ/VFfcFxCBBstX9RbPkyok/2AhpOZSwPv9N119INIBbLxnkaCYTEqIVWWp8hdaBJ0HBuCeQu3dSDO6nEsTpwMgal9IVP6PtgGlME5gclNFwDRJZ78YSgEt2Y40keCxyhMppIN0TmaSum9fM2SqvJKeBJ5mLkDDXpbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y25Qfe2jK5hcBJs1KdpbxrYDsyn+tQcQBbVt7LRR6dE=;
 b=iWbaopY4Qx4PhTm5wiWGf7jA8g4LT6eNvWz++mrnAXEc4PRycGDNmp0VdNIQkg1as3dJ7GAyIsHhIrzAMB8Wuy2goHGZ1K2kDDU+LE5vjXzHQlJJN4918sF1AwnjCobnxYIimFuDjuATru23ehcQ7ZbFjrwVX37wzf6Lf+G1j11CUDfKvbdZLfwgQln8Q6XtFAvnlpGA7rmOHHA1CY6ruccUlwDPIDMiTXHVp4YyFZFRL+TC8NPfMW46Q8tGcFFBUr9a7uxcNqFlq6YsF28a3OopJYMmO0tO2OVSnRyD55a4fcm9kohflJhqy24NxHdyEc9xYqWLwMYQuhQx442PIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y25Qfe2jK5hcBJs1KdpbxrYDsyn+tQcQBbVt7LRR6dE=;
 b=YPAi6lVqTO3xGHjDcD34QPYowhnO4UnRnrdhJfjkCe7SIP8B0aOYuzsmPin2YaBk6T9FKrjbEpgh5zW7RSuVUJSf0W/iAtU5hpIdMgPg/mO5lR2AjOmeq10Y7kvwjVvGaWbLGPZEKWe8kLFaLXTJASAx2O5mgowh558ICnjsHYA=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BL3PR10MB6116.namprd10.prod.outlook.com (2603:10b6:208:3bb::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Thu, 17 Oct
 2024 18:07:22 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 18:07:22 +0000
Date: Thu, 17 Oct 2024 14:07:20 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Jeff Xu <jeffxu@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Pedro Falcato <pedro.falcato@gmail.com>
Subject: Re: [PATCH 1/2] mm/mremap: Clean up vma_to_resize()
Message-ID: <4izjonpaqhkx6p3csfyxcjicgqahbmj2k6gupazehb3l7xhnvi@twlvpx2wc6ce>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Jeff Xu <jeffxu@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Jann Horn <jannh@google.com>, David Hildenbrand <david@redhat.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Kefeng Wang <wangkefeng.wang@huawei.com>, 
	Pedro Falcato <pedro.falcato@gmail.com>
References: <20241016201719.2449143-1-Liam.Howlett@oracle.com>
 <20241016201719.2449143-2-Liam.Howlett@oracle.com>
 <CABi2SkWhgY4amyT+EGTma7a9ymPs7ArnFLkAnm5ko556DpC_Cg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CABi2SkWhgY4amyT+EGTma7a9ymPs7ArnFLkAnm5ko556DpC_Cg@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0119.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::13) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BL3PR10MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a4f2410-eb6b-4224-3105-08dceed68c40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUF6MVF5MTJoU0ZEdlBSVW8yQU01TzVsV0YzaXJoNFMzaVR5ZmtobXEwOHNk?=
 =?utf-8?B?Y0I3Y25pajh0bE9yU3h6VnZTUCtSZTVGYzNXeXl6d0NVUVF2cWU3T2owdTVw?=
 =?utf-8?B?R0IxZHpTZnJGeWpaRGI5VHBMT0JtODUrKzRLUzJBcEhiZHBSVDhPSzRMWkZB?=
 =?utf-8?B?QkNZamNMcUNDMEJzNkZkN2IvRnBCdi9HRmNFNjFqYTFJVERLbWFEQlRtdnhx?=
 =?utf-8?B?MzBXa3FobUJ5SHZGTjJLUVp2Zis3elRuYXhKZk1USmZidm1IYW44MlNwOGF3?=
 =?utf-8?B?L0lFUGJ0cW9hOXM1VUxQVThOYU9MSUhQSHVvR1gxaDNFbmlQaFd5WVIvZDJ2?=
 =?utf-8?B?MnlkTTZ1WnN2blFIVDNPM3pKQjg4V2M2Vll4MmJmQkcvYWNUQUFSWlRKOUVo?=
 =?utf-8?B?M0dGUjlNZC96YVFTanBueGoxSG91akc3UzYveFlFZ3FKKzgwSjV0ZlBWQkp3?=
 =?utf-8?B?UjFLVk5EWEs5Z2dZWkE1ZS95NDgwTHA5TTZ5aW1Na2pneDRoL3BKUndPYys4?=
 =?utf-8?B?Q2w4OG1wM0Z3NThFcGFzc2hpRi9iY005SU14aTl0RkNITUo2S045WFZJWXdS?=
 =?utf-8?B?NFN1Y3M0TWZBZTZvSDhhNGxmdzJLaHBtSTcxOGI3bkowTHNHUU85d3krR3Fj?=
 =?utf-8?B?b2FZRlFJTkpUVXdnWEU1NG9CMW1pYUJhaExHYnhtcjBmajc2YkgwZS9ldUF5?=
 =?utf-8?B?K3hlblBiQXd3YzZoL01Xb0hhL3hXSU82aElFSWFEd0owTTBTZllvR3Y2VEJ0?=
 =?utf-8?B?VVFsYzhKTThRMVIrSG9QbEQ1Ym5Ta1A4eGQrd1lQQ2JQUFlwYzQ2d3RtaE0z?=
 =?utf-8?B?UUxaTVFXb3A3NzlBRHNYYTFnTmVYN1ZBZ1BTZUhycTRNWmRNVmlXTVVtZmhF?=
 =?utf-8?B?aVF3QlArUUxKVGcwRERRSXNaVFNMOWY4dnJMUzN4UjFxOUZ6YktQSE0rRHdS?=
 =?utf-8?B?NmI1Ry9sOG14Y2MxaW1hVG5weDBveld5Z3lyMXBaeVpuRWNQakdIdUU5QXly?=
 =?utf-8?B?aFhaNTJiUnMyNlpTa1dJNmQwOENUZUgzbHhadUN4eEF5SkVXUllqS0w1UmVy?=
 =?utf-8?B?ZURId3hOcnIxTzBDVHF1aklMbUtpZ2pkRjBMeVpWbTN2T2hqUHNTbFlUNHhI?=
 =?utf-8?B?akJQWVRLeWI4aTFmeFlvalpyZGdYdzJCdUYvUzFtWVg0eE1DZGdFZmt5VWZ6?=
 =?utf-8?B?eWczcnJRMFdVSGRWckg5VWYvcTRWSmdnam9NbC92dFAwOFZMQ1VWRDBNRFNa?=
 =?utf-8?B?Tk5NVWZhSWVNR1hLb0xGRkVKa0tlaGJ0TE1ZN3ArOTFpU2R4UlRiUFViK1Ey?=
 =?utf-8?B?UFFKUGdnMm5WWnlsaVFweVBQNHV0eDR1RjZkcFQ2czk0dU04LzBhVDVZY3RZ?=
 =?utf-8?B?RnZscE5zMThUbjhkRHBwOFhmUS84K0dSMktkUzNRcWM1dkpmU1FLcVVZOWk0?=
 =?utf-8?B?alJUY1hjemZwK1d3ZFRMY0ZLZEFTc3NFRGNDdis4WGVtb2dZRk9XSmJEcG5Z?=
 =?utf-8?B?Z1UrVVpiWTgvcUdZMlRsKzZaVU9ZSENMQ29rZjIraXUyZGNzSlplRlpkM1h0?=
 =?utf-8?B?TU9tS3dmZmd6dnp0QTRDM2hJVlNSZnpmdlU2U1U2UWxScDQvUmlOZGRraVR4?=
 =?utf-8?B?cUxPWFk0QlZuVVdUTjBXU1hpN3lwMlZzVVJ3d2MyM2xaWWY2aUdlRURrMFhp?=
 =?utf-8?B?OVNhUUZSbytPelBIaWh3b0l2dm5YUXpMY2RyelAwSlh1b2lHcmJRTndZV1Vt?=
 =?utf-8?Q?KR16itUFUTYNDQpMu5pmCg0ytwUxG5HwDmbNVgI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z29raFBFUzhtUTdmTlhqS2tiQjA4UGQzQ0FWaURHMEc3cUFIcDlJdXM1UGJY?=
 =?utf-8?B?WkdobVRIOVNjdzR3MHJVbHdMbGp6cTBVN1RKN1FEbmo0T2dMYitSdmUrTWgx?=
 =?utf-8?B?elcwZkpPdzhicnpKOE1ZbXpNeTdxMm5idVVadlNLeWZQMzdyR3RSRE8xV0k2?=
 =?utf-8?B?eW9UL3h0UEs2MXFBTnk5czVRNk5VTm5kc2hNdmlMdzhWTThPWFNnN011cUpw?=
 =?utf-8?B?b3Z0N1BwQW5CVUY5UEp5U2RmQWZBZ0FNU25pbTRLNlc0NllMNHQ3ZW9mVWx4?=
 =?utf-8?B?alBiZGR2VG1yMmNtdWRpbmRUZUFyN1ZsK3RzaDlhbnIzOWpPeWVRVnhtRFlX?=
 =?utf-8?B?ODFDQ2JCRVlhWVp0Rk92NjBXUVJMcVRUTmpCWDlGSzA2QjV3TzdhRnI3Q1JQ?=
 =?utf-8?B?a2xjUXlKYW11UGZWc3NKTUc2Vk0xbjRJNVpQLzBHM0ZDRzZaMG5XMnFtTTZT?=
 =?utf-8?B?MEhsTVM3QTZVRmJwK3hsNGVYTi9uTVNPN2JEblNFejRpRVQ4eTJlQVlOWGZ4?=
 =?utf-8?B?RCs5OFdockpMWEdQN00wdW9zaTFlajZHTFR0L1J4WUlnUVVyUGFNS0NCRmVE?=
 =?utf-8?B?NmMxUzlKMXgvODBpSTFxOE9wVmRIbVAxc2ZyeTdEVXpxMzR0ODFDdnltVGxn?=
 =?utf-8?B?LzV6K0Rpa3FzaFo4Z3ZFTURYdXo2ckZacmZDdlkxUmZFaXoxeXRlenJPNnFJ?=
 =?utf-8?B?TE9SdlNmc21GNnJ2RmRaVTBJOXZ4M21VVlhwRGh4aUdIOTdYVFJXeCtVeW9y?=
 =?utf-8?B?UDk3dDcxR2pSbVZGSG1tMXlMTEFyc3Z2NjhuK3ZPUFdMaWJoeVV0ZlFFb0xP?=
 =?utf-8?B?K0tKK3NON3VuZWxVWFRUcG95NFMwYTBYZ2x5ZXpOTEZqTHJIVExzSlMrQmhL?=
 =?utf-8?B?c2JGcDdVY3M1aHpzTXdYU1RxS1ppUFZvNTJveGNxYUx4bUpROTZ2Qm85QWJ5?=
 =?utf-8?B?T0NmMmF3cGw2WVFyZDVnLzJYczFTSTFiQ3RWczgrdW9ERktWWFlUdm5yTE03?=
 =?utf-8?B?YlFEWWppTkY5MHVmZ3VXRDVKcm5KY29jNk5SLzlaMGVBZXpzbDVWZFp2RkIw?=
 =?utf-8?B?cmZjQVYyL1p5VFQ3MkJLd2lsN1NzbUVSL2s3dmNjUVhDd2VSQXlONXBYQm1V?=
 =?utf-8?B?Rm1zTkZJd0RiY05HUktVbnVxdmtlYUNVSnQzWE5KcHpkWWZ5Qnkwdm13WC96?=
 =?utf-8?B?QWJnS2lUdnpKdnBmNXVXOUFSVVpCUXdMZXQ2bHdxUjErczVzeStURFhDWGJI?=
 =?utf-8?B?K0tZVVJ6Rmc4YURxUDNtOUJmZXNwOHNJZStRQnFHY0RJREpsRHNTY3V6ZDly?=
 =?utf-8?B?QUxhdHlZTjRGd2xvSUpNbEQvR09kNWxXck1scktsdTNOdno2RWk5bXZ6OTRo?=
 =?utf-8?B?SFZTNzN6Z01aWEpIejBJQUIzNk81S21zK1NBa3B5ay9LZDRrcTB0NTBwaUFh?=
 =?utf-8?B?Smg3aTcrSTFCUDNIbDYzTis5UlE1d2RyaVp0OXh5K3FFeFB2M3pSZ25XYmdM?=
 =?utf-8?B?cllwMXJBVmg3VWdXalR1WVYyR0ZLLytReG1RUm5IUHM1dlQzTEhtSitWQ0E3?=
 =?utf-8?B?d20zMWtobmJEMFNnU1VodjlpOHkvTTNoOXcwbnZ4UUhsOTU5d3NBVzRjSEpR?=
 =?utf-8?B?NHl3T0toUis1MVEyWGFCWHlwOWdVV25qeWtYSHRMTXlPR1hwUCtwY055enk2?=
 =?utf-8?B?eHY2SHVKdk9nenZ5SENvZ09jRFgyL0hRQ2MxM3ZKRHErZFFqdEJMdG01VjRw?=
 =?utf-8?B?ejVLNFlSZEJxSzVxT3NWL3QvTlV4a3dOTFI4UnZwVXczOUNXNzZ6QWQwT2JH?=
 =?utf-8?B?OHdGbEx2TTd3cXZRMEx2V3ZTclpwREdXZXZxTkxCajdueThyTWVLMTZwUEw1?=
 =?utf-8?B?c0hkVlZXWGJ3K0hJb1VrcEZ2V1ArMksxWkpCR0NHTGxrQU0vakdTVG85d0lk?=
 =?utf-8?B?Y1Frb21IajI2NVJSd09oTzJ1ci9tMjZDa2dCam0wbTVvbEUxVkFKeStjbmQy?=
 =?utf-8?B?clFSWVU4QmFiblhwOUJET3lHdmRBK1p0VDA5c25FNzdBakwrMkphMFJJVllN?=
 =?utf-8?B?OFRqTjFDN0NmQVlTZXlwVkY5QXVkL3UzQThGOGg5V25XOUhjL0hoRHZBNlhZ?=
 =?utf-8?B?THF4NFAreEtISm1EOVl3S2ppWGJKTENzMU5MbVlCUllZRTRQQUVsblZOTVgv?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KC3p8O0S37+wW1+/vQIKR8vh2U9kPCrAB9q63GSzPihT6Pn+kNPq8tiQn0DdtONoxED0yaXwidk4SJLfka0xq813lSGkNdRrtHByWu/I/gjejACsCfpH3zLTWWa8QmGHr59V/NqVEPdGi0b0LilmgSs+x54VHaYEvrw4vGgmY3AcDH4g5vb2duzEiLa78nHPhjtNRvASSEPNKiyFUXi7QZ2pJoDXl8rRE7vx9P1u3jBVNQvD4JVrtGUPFYBsJAjdor4Am8xHRx8hkF7VxtI9Z1WkT23Azly70rfkKB+VVnpru3PMsKhnEJZ8swUVW8T2Kq4p0w3y5TrEnPkNSOZiiH81ylhHAhtOMyk72fXpHO8qNhzBLvHyHztstDig26+VyZ+E60ZiKtSCvDPwMwdx2lWrXF1h28MXiXZQMyc9QkB+GO1DIA9TxNf3UwCs6lyYkBC0zhOSR0hFEFF28da7dR8tWvUGdps1yljkeXNlmvh5d51wq5J+98SAZfgbHxW/pvf2uWSEJuMVPTsKL+ySFvOjUjm5h5XdlHbiHamk0dIB8HK3ekUQ/DIxIVz9frYKniR/LIVrc+lN8mq1R7HV5uGJedL/TWolC/BRsIc1Rzs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a4f2410-eb6b-4224-3105-08dceed68c40
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 18:07:22.4676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jUgkVDRImLJEydT4Rsii28RPT7JjDonD+JR1RJ5bKdsRu5tciFB8jQBdLlpNx0bsO3+cldX8PBp59SeQsJ4PUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6116
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_20,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 phishscore=0
 adultscore=0 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170123
X-Proofpoint-ORIG-GUID: vaq87n7pdarTU9SWMtfjMJl_EsZ_bUl6
X-Proofpoint-GUID: vaq87n7pdarTU9SWMtfjMJl_EsZ_bUl6

* Jeff Xu <jeffxu@chromium.org> [241017 13:55]:
> On Wed, Oct 16, 2024 at 1:17=E2=80=AFPM Liam R. Howlett <Liam.Howlett@ora=
cle.com> wrote:
> >
> > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> >
> > vma_to_resize() is used in two locations to find and validate the vma
> > for the mremap location.  One of the two locations already has the vma,
> > which is then re-found to validate the same vma.
> >
> > This code can be simplified by moving the vma_lookup() from
> > vma_to_resize() to mremap_to() and changing the return type to an int
> > error.
> >
> > Since the function now just validates the vma, the function is renamed
> > to mremap_vma_check() to better reflect what it is doing.
> >
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> >  mm/mremap.c | 39 +++++++++++++++++++--------------------
> >  1 file changed, 19 insertions(+), 20 deletions(-)
> >
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index 5917feafe8cc..648c29f568af 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -826,17 +826,12 @@ static unsigned long move_vma(struct vm_area_stru=
ct *vma,
> >         return new_addr;
> >  }
> >
> > -static struct vm_area_struct *vma_to_resize(unsigned long addr,
> > +static int mremap_vma_check(struct vm_area_struct *vma, unsigned long =
addr,
> The original function is vma_to_resize, and mremap_vma_check is
> missing this context.
> Maybe mremap_vma_check_resize is a better name ?

Good point.  That suggestion is long though.  Perhaps
vma_check_resize(), since this is a static function in the mremap.c
file, it is fine to drop mremap from the name.

...

Thanks,
Liam

