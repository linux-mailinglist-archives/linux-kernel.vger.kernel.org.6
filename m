Return-Path: <linux-kernel+bounces-276317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE531949257
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 15:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6596BB25BE1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2024 13:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD681D6192;
	Tue,  6 Aug 2024 13:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OrIJTMmT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OKNLwDee"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8047F1D47C8
	for <linux-kernel@vger.kernel.org>; Tue,  6 Aug 2024 13:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722952137; cv=fail; b=uECk5etr+BjhV6bpjvk0eu+tFr6qHLUmWWYwiysopFFu5qFQeTYm0sxd5UA9cEZP1qfeyYWWibYhc8y7/2zzi6INE18eAqIKbHJgfC7ICujABe5ybrwVgj+tRikRKYNGYB6ox8TYA9JCT6pYOPmrMKlI9hpWUDh7HH5rFmovpf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722952137; c=relaxed/simple;
	bh=fEzAgd+uodqzfhpFXxCTG3B9VJ8/u1uLEzjMkpwt3AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NZUd2ZT5l0QZ7vCTTpooWIHkdbSw4v80CAm+84odzxuuEQnzEvKwBxwoIwrGyBRxqWfaCvTBOX3adpv1xROyncryHIFbwTPEdQ2mFBN4VPztvSF8PW8ckypvGGV0YOra/lOnDdbSDZ6kC06CBT6wI1OknZl74E76+0/t2md2OAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OrIJTMmT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OKNLwDee; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4765kmTe001388;
	Tue, 6 Aug 2024 13:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=cmK+iSKVhqDf6lkEA6rnrbgtcLrQO87A0q8tMpWOH0E=; b=
	OrIJTMmT/d2GqBsWQ3I0Bj2tA1z/XBWR26aw+kQiULZiu+kKOED+cc51d5IN6Lcd
	rSJGbwNYd8qfzNCc0Szq0xObhPuHIoaYV9xxvlDupBp3hv05Mpmn1CDMm7Uo7wkL
	/HBxouCYPY8oyyy68MMrEsm3hg6f10riEmODhOVfJ00BLUEFy9iGlm2JZcYT/1ux
	OlldUL82Fwsq/+5Nkb4qOtW26AyuCaGyj7N8IPYVgQ+60Us63vK0WVa7OO1EYD5V
	YnYLCPLAVf/awoJNLlgP9TY9FDET/u0RH5bmv19+VvS4AJOlcVHUmjUavgqBBbeX
	RcFdXbdqBDkRS411iZZGwQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sbfand4h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 13:48:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 476ClZW4019380;
	Tue, 6 Aug 2024 13:48:44 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40sb08p0nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 06 Aug 2024 13:48:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qSq8x7ERkDc4tGD2XmLAQoekpqEzmOYq7Bg+7M7b49c3sTYilQCKqtO2CYuFq3IdHlE8vELHaviMis8dDLkPispOkCmlHcop8E6gANckD5TYkP0GxIDUy/ge80sI6+ZscySA2a+IGUhtoDs9Q3nHua8KIcp3T8USm5++bzOQpuLsMKNP8WQuV8vbT+d8mu1XxoURG7DI0LecFya+bLt/mZqz2b3XC7SsNJIN6KXSXF2Rf5TtdX1KqPeDWZ+mW5F1Kbc/hCm2zin3odN3MmjAhz53JHz9HGEQIbl2QB/WNlGYtkhr2C7OzyOhmLy4jr82NcGx99QfUNZ9rbBZhwme+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cmK+iSKVhqDf6lkEA6rnrbgtcLrQO87A0q8tMpWOH0E=;
 b=J5g11ea9FpowyP+k2nFEiqGWL7/I387JyCxmYUpgN6c1P20EtRH//x3K6qx1E7DNH0pJR9LXprIUJdz5XCPcAnkT1YssyfRBH00qivSvNmMRawdpEp1g4JxAf/XNGrFxIeIIYzjwfSh6IUBl2n5eFYxYADgVdp8bSq/Epn5lqLlBAjr04kdKjQe/A8GXL98o4TwI9wG6stSApGs3YdlNNVvNUQX/2F7r+xDQLuBSKjoHSkS4KvYk8y/T7mKugcJluFdIax10H093nWushIQyRBMNoA7NGhvoncFIt1dtkqk/s6AIRf+SjSjeSRyEot6an9qXLjLckaH2F2N7vAEVLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cmK+iSKVhqDf6lkEA6rnrbgtcLrQO87A0q8tMpWOH0E=;
 b=OKNLwDeeTsyP93K2LPFS5wctn7+yuLuGqD46A7sFgllDdYiRWcSni+tX3HeFVTSWbXBTxMSHrRqvGoZGzq37ifGe6fhypE/k7ITXAIkcmZIbKBkq/zmjQ4Yjz6SmE47SRHDM6BW15bNS8lrFZyOnqm6EWhvb8l4zWW7pjtCQRQk=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SN7PR10MB6364.namprd10.prod.outlook.com (2603:10b6:806:26c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Tue, 6 Aug
 2024 13:48:37 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Tue, 6 Aug 2024
 13:48:37 +0000
Date: Tue, 6 Aug 2024 14:48:33 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH 08/10] mm: introduce commit_merge(), abstracting merge
 operation
Message-ID: <415d9d9c-7b63-47f0-9091-678f0d8d1268@lucifer.local>
References: <cover.1722849859.git.lorenzo.stoakes@oracle.com>
 <3b04eb13b499df3ebf50ae3cde9a7ed5e76237fd.1722849860.git.lorenzo.stoakes@oracle.com>
 <20240806154116.015e329a@mordecai.tesarici.cz>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240806154116.015e329a@mordecai.tesarici.cz>
X-ClientProxiedBy: LO4P123CA0128.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::7) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SN7PR10MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a8e1c7c-1d7c-442c-8ed6-08dcb61e7899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bFBlSEd2aSs3TzJuV3NUY1ViQnlIS29zZi9PWGRjZVhXbnd5V1ZkZGNVN2g5?=
 =?utf-8?B?Y0RROUpIck50NEh1dUhBYVVVSnRSREUwS3FydWhZanlOcWFxQnZrdFE2WGhi?=
 =?utf-8?B?MCsveGFoZjErU3pDUWloenNxSU5VcmZMUzdhZ2YxLzFKWE9YRm80dnFSdjNI?=
 =?utf-8?B?YUl2YlhIdFZZK0h3TlV3bTUvZW1LQXgxQTdwK0VvNkdNMnBkRnhMREdmOWhH?=
 =?utf-8?B?cU9QYnMyVC9aTEFrZkVHRXJjYStNSHhXaWJiZUJtMzQzckgySHZ0VG53UDQw?=
 =?utf-8?B?cE9ZQXduSFRjSzBxK1hITGNHdSs5bEhNdXJXQ2wrNEJwSDMyWThtWUV0VTVL?=
 =?utf-8?B?THBDc25Ydm1oK3ppd1N3UGtHdnh6bG1iekdBenJucmYwbzFLcFRWR1FGdnFI?=
 =?utf-8?B?Q2t6ZUtWUDRxWWZxYVZhdWxjbTNKR2RvQ2gxY3JqZkNaeUtqWUdMVElidG1N?=
 =?utf-8?B?ZmY5OHY4d1Myc0FGU3hGamhVWGtCeUJPaTBmVzZlcm1OdUwxTGZadkRzaklw?=
 =?utf-8?B?UjlkeUZBZnB1MWliU04yVmxhR3ZYdXk1ZVlnY1B5Qkk0T0ZjS1daSVZtM2tv?=
 =?utf-8?B?dkx0cGtCZm9QcG13RlJ2NG9JYm9CZG5HeThzRCtYSnFNeWV0UlNBWkpoZEdz?=
 =?utf-8?B?Z2hsTHpINDlaQnNkMnlSMWlVZW1SdnAySFZVK09TWnZ5L0sra1NOR1JOdWlK?=
 =?utf-8?B?QWpkcVdxRGVIMGZMV3pvTDRjREI1SXQvSVJRSnRYcHNaNUNyeTVWUGN3RklP?=
 =?utf-8?B?YmtuQnZMT2t0ZmhtNk1pOVlaNDNLYTYzTWdCaFVtS0Q2Y012dVlBdTdKT2xI?=
 =?utf-8?B?U0NQVlpmRnJGT0djdHhoc3hpd2YzL2p4ZUEyenIxUkFRV3QxNkpJcGE2MzlJ?=
 =?utf-8?B?RFVDQTBvWXBZN0toVmhwWjNCZU5yaTR3NDE3cnlhN3A2Q3gxdlN1TzFNMytt?=
 =?utf-8?B?cDVNQUZaZWFjNEE5d2NwbjYySFdqMHE1RG90Y2JOZDV1ZHp0UHUvTU85N1J5?=
 =?utf-8?B?R3BWRTJReGE1eUcrL3g5eTU5MVFyc3E2K0hiOFM1WVpiRllRcDloYVhjSC95?=
 =?utf-8?B?U0YrUFhMMHROQ0hRVXorMndPazNaZC9PbnR0QUFzVmdSc0E2cm1zMEhDZVE4?=
 =?utf-8?B?NC9VR3J3UTZxSmdrS0xIMFFwL2hRKzJnNVRZS0N1ekJUUzN2UGVxMm9UalJD?=
 =?utf-8?B?K0Z5Y20xTFRjbE01M3cvYjNkQ2NYYkxUUm55Ky9zUlR5ZzVDa3dUbVFoWG1k?=
 =?utf-8?B?TjhLNnZZNzZrNllKUmxRRDBYL0g0NzNxc0Z0NEhHYnZCcEpwUndGYTBlSWV4?=
 =?utf-8?B?QWFld2NCTXY2MXR6TVp0WnE5THJzZlZJcnBMTmtjSUQ1MFk1QWhCVDNKYmw1?=
 =?utf-8?B?aW85b0RHWm1Kc00vSi9HUTFVK1BzN2VLNXIydVRSQ2dIYkh0aG5Ld0xZNTlK?=
 =?utf-8?B?Zm5RN1VLMVVCYWgzMXhKVDd3WDM5UHFrUTZGb1F6RTR4TXF4RytEWEZtckV6?=
 =?utf-8?B?a3dQcXFGUjRJOHRqRU1KeFVzcVQwcVgza3dCY3RtN2lTcmlmMVA3SUZpdkV4?=
 =?utf-8?B?cURMTFBpL0l3MEVxaWRpK09DSU9iaElWVGxqWi9ZaXRqSCtCZ1NVaEhwZm5w?=
 =?utf-8?B?VndGdUhrL2IvYWVWTGJ3WTJiVk5ueEFWSVBCTTBMNks3aWNwbkQrSmpJNkhU?=
 =?utf-8?B?dXpmZGw1MVJjM0kvK05MZU1IeUNOZ1hPRUFvOWRUTlE4emVydmJ4czk1Q0ZO?=
 =?utf-8?B?cGxOcVBsODFEMWZiRi9lMkdYSDNVT1A2YnY3S0lybjJXQ0tvTXk2aXJwZkwy?=
 =?utf-8?B?QVFWUUVEcFlIbjIrcDI1QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjJEaStUWk1VLy84bUhpeVF6MkNubE9ueWR4dCtuQzRoT2lxbHE3S0d4dWd5?=
 =?utf-8?B?aXprQmVOUGd6bzlNdVpWOFhXcTk1MVlHM0JLeTUwblFKdEdIQ1JUbEJWLzhx?=
 =?utf-8?B?ZnJMbzJrWjBvT296M2VQVUhuMjRkQnkrQnNnR2tVOXg2d3dPUE1LSmU4cTl3?=
 =?utf-8?B?UW5EdkRWVUdZeS9naUZKVFhTTXJvS0JzVktPRlh3QnlQSS9ramlmT0xZbkdE?=
 =?utf-8?B?TjE0RnA3NTFqbFhYNDZQcGxDTHdZMEczOHZkOFYvN3FLek54dm12RHY3ZnV1?=
 =?utf-8?B?L25zc3FqSHRaSWFHbFJOSjhRVDlEWkVQeUEyZWtTUHRvNEhINmwvcFNEUGRH?=
 =?utf-8?B?dVV3S2NXdkk5d1hRZFNURngvNExYWDdxZFAyVG02enNVaEh6SjNLeWZRT3R5?=
 =?utf-8?B?TWxqWWRNNFJEQ1VyRG1Qa2lWaHJSNmNacnN5M0dYd1RySTJHL3RMOXhlYVBD?=
 =?utf-8?B?Umx0ck1RTDN0clFuQlVjRVVWWkhPZUk2eVZNNEhiVkI4K3lveWg3Uzg2c085?=
 =?utf-8?B?clo0cVNhUTdPYnVtcGJSallJYzkxRFM0MW56NlN0ZllPY1BJSksxd3MvZFhQ?=
 =?utf-8?B?aGRma1l1YUttN0RIbU1zaDZlZTJVS29FU3lBaHFQV3lvdmFKY2t2bGJSQ3Bp?=
 =?utf-8?B?TThpNkxWWVZwUFB6ZnFwUjNPUXdML3dQZFR5UnNpMUlxS0dmU3Z5Zk5OSmtx?=
 =?utf-8?B?MnpPbmJSOE1QMnU1aVc0YXVlcmU2WlBsWEREZnFHdDRYWEhHU2pnZEVYYXpZ?=
 =?utf-8?B?VEh1NllGeHNPMUNUS2E2aHg1Q2Z4WEdlRDNDT29ZVXY3ZVJsVTlaRk9HWWtM?=
 =?utf-8?B?MjFHWEdxd2UwZlpURVJSZ1FoYU9jYldGajhxRnBWd09PSVFTK3F5OFlyK2dD?=
 =?utf-8?B?eGJUbGl5N0NldzJscEZEeDE0WVcrWmRDUnVUNG1qUVBBa0JXQTF3d2NkM0ZC?=
 =?utf-8?B?SWd0d2FLRG51d3ZkV2pMUEpzajBhcjVKeUo5b2RHVkFzZUE5WkRwL29KVHM4?=
 =?utf-8?B?dlZrMUxTdWx1ZnZrUklWSjFNNk81akRqQk9uSmg2L2x3TC81ZmYrdUpBdWdh?=
 =?utf-8?B?M3h1a2tLVTlUVWkwM1F0VTlOSXpRQ3dhNmk3ejBFTllPQTNxVGpmWEVJUW9Z?=
 =?utf-8?B?M25wOFdkZW1uc2dEbWVSRG9zRzY2TzFRZHM2R1dpbXdCK1lHU1VzSW5mOU9V?=
 =?utf-8?B?NnpPSlF0TUEyKzlNeXIxdlMwdVJTWDhWbkVOVExVZy9ZQVpJOStuUW92eEZq?=
 =?utf-8?B?QUNPU2RTUWpydTlRZldkRWJzYkxEL0tVWXY1eGdwdUYyYU9LaittZ0tXZEZN?=
 =?utf-8?B?KzllK2crVERaT0tkb2FwaGpuUGd1ck5vazVPZmhWUXJmazBjUGdxVER0cXc4?=
 =?utf-8?B?VmxEc1gwL0Q1L1BoR05QMDZ1dHU3QUk4VjZEb0QwTVJmcnQxUkEvQW1SR0tJ?=
 =?utf-8?B?VGd2OGllMjQ3Mnc0bzJNMTVWTHM3Zy91Vi96VGJ1OWZpQkFhdVJ6dXFvbncw?=
 =?utf-8?B?eThZZ3lPMTI4SzNJcUNzM2tNL28rUy9wbG8zWUY1dHVpNkVWdVJoUnMxYVdj?=
 =?utf-8?B?bDhIS2VJM00zeVBWby8vZ3p3NTA4RnZPVFo3UGZoVEczMmllR202bmRoQzl5?=
 =?utf-8?B?akwxWmpvanBEelZza2dpN01INnVqT2d4SHArdkc4QUVqTWEyZ0JqbTg1TXpD?=
 =?utf-8?B?dmpxeG1tUnkveWI2T0hRTXBYd2lMWGprWGl3NVVpQzg5bk0xc3BzZUVOT3Rz?=
 =?utf-8?B?QmhPcVpqTHhGeitKdW83QXB4SHY2U3piZjdSL1h0aUtjVkZiV1E3UW83R2Jr?=
 =?utf-8?B?UVMzNjV0Zy90Y29GVjB4N1MwaEtEQ3BXbFQ3R29vdFozUlJJKy9jVmovNEpM?=
 =?utf-8?B?RTN0TVZMT3J0OVN2Tk5aeUdBT1F6V1JWdkcwcUp0K0NCZ01EVE1tQjA5WTBu?=
 =?utf-8?B?c0diSngwYjFhM1VGS0t1NGJOWTdtZDhUd0VRRUNwNHVzZExyLzFNNXJ5K1l1?=
 =?utf-8?B?YzB5TFRWZm1YZWlac0J0QlhSZEl3NEhmd0d3TXlXOW9pbThSOERtSVc1a3RB?=
 =?utf-8?B?bm5hc1NZTWR5WjBDSnBGZTNseVI4cXpGdW5VdmNFcUUvdWsrblJXbWVTVVlt?=
 =?utf-8?B?VUowb1NiZGNtdFdMMDc2ampnTUVCbEQzZXgzRDY3R0JwQzU5dEJqeVNCNUI2?=
 =?utf-8?B?dlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VyApC6aqqpNp43ChvpPrjVhKiHRmZ0DX+usKpg63s7ArThoD/r//FtTdDtLWqVdPvw9XCh0u6UOPLJIaghG0Z8klydjYd21Niph2drTFlC9tA4Y1KUOm/w8r1t2Vgz3xsyrQ548AImAS6x7x6Y0yNydkBA9q9yA7p98a1zeMuw7OFe9RrPE37kIXyG9xdoVxtuIfzX3R2FL6MAEg6DiqI1zc8y7bKBuHSkHvd8NNvy96vsLF1cJwDru2j5dw4bxeu6JBySMje1f8ke8TS0qDu1xcX1OkmfUR+yPKXCt8hRFHFuuJQDMD8/kioELW+AIQAq3YmknKsM9t3Ll3qztCyZElpwB6YJX8uKxRM5O5eERqJRHMI0erFttkXJYvVyI5bIz3DZBXwSZLS1pPp2NeO1sZmgoDPMDjX/uHJg+G6hwIbmAC5mY70WANYC+u47cppaV2bTxF7tSBd5ey7skZvAt6TtaFWe42otAvoEA1pV3JDpa8kSKrCepBHidbGsDnKuk1MQb2fFqRGACssP4Qn8Oxak0IatHL0tNRdiB4FyK3+fuvtFHxLU5eQWB2F4p3HfwUyYdSGz10bNXQeyFp70evDaQQPeqY/kvWJmtGXJo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a8e1c7c-1d7c-442c-8ed6-08dcb61e7899
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:48:36.9414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K6IAI+oGkvAyWFSyDGnEHx/VOKZH5wkDM4YCFESBv6PcqSOkANFg+KsTNesXACODLaUvpH/9P9okLzGJwbGnhQx0M77MRx6AomKyizYR1mM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6364
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-06_11,2024-08-06_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408060096
X-Proofpoint-GUID: 9X5GAK-96EqEtxslhQ7r_MehAvDjTJQd
X-Proofpoint-ORIG-GUID: 9X5GAK-96EqEtxslhQ7r_MehAvDjTJQd

On Tue, Aug 06, 2024 at 03:41:16PM GMT, Petr Tesařík wrote:
> On Mon,  5 Aug 2024 13:13:55 +0100
> Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > Pull this operation into its own function and have vma_expand() call
> > commit_merge() instead.
> >
> > This lays the groundwork for a subsequent patch which replaces vma_merge()
> > with a simpler function which can share the same code.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  mm/vma.c | 57 ++++++++++++++++++++++++++++++++++++++++++++------------
> >  1 file changed, 45 insertions(+), 12 deletions(-)
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index a404cf718f9e..b7e3c64d5d68 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -564,6 +564,49 @@ void validate_mm(struct mm_struct *mm)
> >  }
> >  #endif /* CONFIG_DEBUG_VM_MAPLE_TREE */
> >
> > +/* Actually perform the VMA merge operation. */
> > +static int commit_merge(struct vma_merge_struct *vmg,
> > +			struct vm_area_struct *adjust,
> > +			struct vm_area_struct *remove,
> > +			struct vm_area_struct *remove2,
> > +			long adj_start,
> > +			bool expanded)
> > +{
> > +	struct vma_prepare vp;
> > +
> > +	init_multi_vma_prep(&vp, vmg->vma, adjust, remove, remove2);
> > +
> > +	if (expanded) {
> > +		vma_iter_config(vmg->vmi, vmg->start, vmg->end);
> > +	} else {
> > +		vma_iter_config(vmg->vmi, adjust->vm_start + adj_start,
> > +				adjust->vm_end);
> > +	}
>
> It's hard to follow the logic if you the "expanded" parameter is always
> true. I have to look at PATCH 09/10 first to see how it is expected to
> be used. Is there no other way?
>
> Note that this is not needed for adjust and adj_start, because they are
> merely moved here from vma_expand() and passed down as parameters to
> other functions.

See the next patch to understand how these are used, as the commit message
says, this lays the groundwork for the next patch which actually uses both
of these.

I have tried hard to clarify how these are used, however there is some
unavoidable and inherent complexity in this logic. If you don't believe me,
I suggest trying to follow the logic of the existing code :)

And if you want to _really_ have fun, I suggest you try to understand the
logic around v6.0 prior to Liam's interventions.

We might be able to try to improve the logic flow further, but it's one
step at a time with this.

>
> Petr T
>
> > +
> > +	if (vma_iter_prealloc(vmg->vmi, vmg->vma))
> > +		return -ENOMEM;
> > +
> > +	vma_prepare(&vp);
> > +	vma_adjust_trans_huge(vmg->vma, vmg->start, vmg->end, adj_start);
> > +	vma_set_range(vmg->vma, vmg->start, vmg->end, vmg->pgoff);
> > +
> > +	if (expanded)
> > +		vma_iter_store(vmg->vmi, vmg->vma);
> > +
> > +	if (adj_start) {
> > +		adjust->vm_start += adj_start;
> > +		adjust->vm_pgoff += PHYS_PFN(adj_start);
> > +		if (adj_start < 0) {
> > +			WARN_ON(expanded);
> > +			vma_iter_store(vmg->vmi, adjust);
> > +		}
> > +	}
> > +
> > +	vma_complete(&vp, vmg->vmi, vmg->vma->vm_mm);
> > +
> > +	return 0;
> > +}
> > +
> >  /*
> >   * vma_merge_new_vma - Attempt to merge a new VMA into address space
> >   *
> > @@ -700,7 +743,6 @@ int vma_expand(struct vma_merge_struct *vmg)
> >  	bool remove_next = false;
> >  	struct vm_area_struct *vma = vmg->vma;
> >  	struct vm_area_struct *next = vmg->next;
> > -	struct vma_prepare vp;
> >
> >  	vma_start_write(vma);
> >  	if (next && (vma != next) && (vmg->end == next->vm_end)) {
> > @@ -713,24 +755,15 @@ int vma_expand(struct vma_merge_struct *vmg)
> >  			return ret;
> >  	}
> >
> > -	init_multi_vma_prep(&vp, vma, NULL, remove_next ? next : NULL, NULL);
> >  	/* Not merging but overwriting any part of next is not handled. */
> > -	VM_WARN_ON(next && !vp.remove &&
> > +	VM_WARN_ON(next && !remove_next &&
> >  		  next != vma && vmg->end > next->vm_start);
> >  	/* Only handles expanding */
> >  	VM_WARN_ON(vma->vm_start < vmg->start || vma->vm_end > vmg->end);
> >
> > -	/* Note: vma iterator must be pointing to 'start' */
> > -	vma_iter_config(vmg->vmi, vmg->start, vmg->end);
> > -	if (vma_iter_prealloc(vmg->vmi, vma))
> > +	if (commit_merge(vmg, NULL, remove_next ? next : NULL, NULL, 0, true))
> >  		goto nomem;
> >
> > -	vma_prepare(&vp);
> > -	vma_adjust_trans_huge(vma, vmg->start, vmg->end, 0);
> > -	vma_set_range(vma, vmg->start, vmg->end, vmg->pgoff);
> > -	vma_iter_store(vmg->vmi, vma);
> > -
> > -	vma_complete(&vp, vmg->vmi, vma->vm_mm);
> >  	return 0;
> >
> >  nomem:
>

