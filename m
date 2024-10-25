Return-Path: <linux-kernel+bounces-382531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4B29B0F6E
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 21:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26648283AAC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 19:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B9D20F3DE;
	Fri, 25 Oct 2024 19:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CqtFrjZ+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h9gmRlsE"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD34B20C31C
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 19:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729886071; cv=fail; b=XEVP6A1hEGOGRyWYgVRz3CxB4eM4fYoJFIn+42PlcIkVlsxhI/xnM+3M+SKymK8YHVykJNLhx3K1MQV/DUGUtz60GrZHa2ZHAAD7EMer6zwuYy2R/CLkM1eEXMX822kxtG8n98gpN6MFQr9Ci33XIn6XquFyCO5ZuI4Du+Bi7QI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729886071; c=relaxed/simple;
	bh=yQtTFjSUDKskN6PEvEb4yi5VVgJ7ie8Xdo94ropqEm4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ckOxenTKgVmQWUo2R2klsokmnY0VkwXnSCvv9ccqGj44Ce4SGgGPJoZQ6+N6E5jehNQ44Ovjds5rwK2tgLwAuun3xiPalzMFjVubwTpZ3FYZiEAfFKdPsmvEyAbRvORS99SwsPLW/rmFXCf/AkLYrP9CY+hBzpPGgOJyEWIhV6I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CqtFrjZ+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h9gmRlsE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PJdVRv023225;
	Fri, 25 Oct 2024 19:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9mbFcOv9eW5lsTk2/N4jTEK2swV+fB1Tk74TaOPLL5c=; b=
	CqtFrjZ+Dtns4kZa2htZrddyaBj2LLPTva+FBD4WD6/OTqTt/lPCGxQl4fuUjKYw
	ajJZV87vxEM6mNbfMnJDHg+7UXrssEz8JbskQWKkwKb3CWcZyM273cIn7tOf+15h
	V7hw2HYHxHCWx8vRzM7br/zwdpFlJLmH5E+B5s3/HLpyCNmScDQzc60N3P6xUQ3x
	GRFWGlg9tSanBXipjHJzaFS+SumPBco030BzqjKOzgQNJlHZ99A1qcNbvBxdqHHn
	RR/lT3qdUOeTWfihlNoUs516feeEzCnUyJzwjhPqWRlMjxWIMZgDL+5ukh7WAlnq
	+xRUqL7isccTGNm2dwXvlw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55enn0e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 19:54:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PHoE0P008591;
	Fri, 25 Oct 2024 19:54:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42g36awvt6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 19:54:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCidW/IqJfJ6nTjvoQRb8Hw8D6RZcdUjHcshnE++ebHnV/MxhKuEoPFqVP9K/0kR7BPF/WwNApF7cXkj7E6S9SRDRxYV4qvEBgzdTp8WF6Qm0l3xEHLZNQ3nvhqGKuEV8kgwTC+yV+1l3ALGT5V4z3gVdvF0zf0Dg++SCJcnT8HtBtXFFPnAfXKTl6s6iyDBvH1g2Twjl33TISAzNtKyCeiainLWA/tNJT6vNZM/eq6rVmH3Nrvii4wU8VSp2yta7l/b7MZ6dO18fqXu6M2MLAYTKE4wOqe3hSfdgIr61m4UU3gWiQm2+t/IpNjZhNw8xumVOYMFyBjA0uxQPxK2gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9mbFcOv9eW5lsTk2/N4jTEK2swV+fB1Tk74TaOPLL5c=;
 b=RrEgnrxRIt18E5tLWbQDCNU1z8gJ59YQd2eDUoiiAZoqPXejgh6rTIELHapsW//xnfF7K82WrhcK9nW5zHpMmDoIkUm4Mj2QOvn29mSywbVCe35b5zhyc0D6+alodVx8bPdtnG3N9sMVVjY62RUOwMc/BiJ71/N7QWiz8SSlVAr+beyhb9tmBc3Zeup8x/Q56J1QwCceYdu/IPSP8Ny+h5YZzmne0rEidcDmNgi4/VIwKLopiARPevWv0EYQKAUegFCzKqD3LLHJQNrXIx+CA+/NZpl0mcrtjFmA1vJDwsGno0sEfHycaq9RYp+YZESd2UqS4SFoKfJE3515ux62Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9mbFcOv9eW5lsTk2/N4jTEK2swV+fB1Tk74TaOPLL5c=;
 b=h9gmRlsE0hPn795Zbr6foWAXwn0CxXXvzr21flmYDP69JDImcTCX8aEw1uB/cbrYS9v0Q80mYZEDmiYegY5ri3zA4KI+dec4ZhIHl6vJgRkiwQkFc2KhRuqlRSxGBD0edOUh6i3PI9y6EVeBF9BAyRKVtcXhUZC38PRMmE6OOh0=
Received: from DS7PR10MB5117.namprd10.prod.outlook.com (2603:10b6:5:3a6::17)
 by DS7PR10MB5087.namprd10.prod.outlook.com (2603:10b6:5:3b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 19:54:07 +0000
Received: from DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::a2d3:a2e9:efcf:46e0]) by DS7PR10MB5117.namprd10.prod.outlook.com
 ([fe80::a2d3:a2e9:efcf:46e0%6]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 19:54:07 +0000
Message-ID: <b4ad4b6a-f0b5-4ed1-a49a-d4e9ed0e4831@oracle.com>
Date: Fri, 25 Oct 2024 15:54:04 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 16/17] maple_tree: remove unneeded mas_wr_walk() in
 mas_store_prealloc()
To: Wei Yang <richard.weiyang@gmail.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, liam.howlett@oracle.com,
        willy@infradead.org, surenb@google.com
References: <20240814161944.55347-1-sidhartha.kumar@oracle.com>
 <20240814161944.55347-17-sidhartha.kumar@oracle.com>
 <20241024012038.zf3dpqsflnyi4wce@master>
Content-Language: en-US
From: Sid Kumar <sidhartha.kumar@oracle.com>
In-Reply-To: <20241024012038.zf3dpqsflnyi4wce@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR1501CA0023.namprd15.prod.outlook.com
 (2603:10b6:207:17::36) To DS7PR10MB5117.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5117:EE_|DS7PR10MB5087:EE_
X-MS-Office365-Filtering-Correlation-Id: 30bf9361-5ce7-48a0-d087-08dcf52ec8c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MTRyeng1d0gzaWtjWFlwY3J4MUZ6b3h1dFBjNjcvck9MVlp0a3ZKSHpzRisy?=
 =?utf-8?B?Q05rUVVEKytUUTZ3djRFM2xYK1lyMFNvWkRaZWxnK0R1aGNBaU83dGx5Mmtz?=
 =?utf-8?B?MnoxWTFyS0N0YUJyUGl4bHI4SGhySVR4aENxYjluUlMvOFlLWStPeC9SWWpS?=
 =?utf-8?B?c3ROeklxL0lEbzFpeUo1anlpYlBtamU2eEg1enZPK2JBLzNZWVdGc3E2a0xL?=
 =?utf-8?B?QVJOeE1rWjRGUVNaeHMzUE01Yit3Uy9KTmVtMi91djRhY2lCYVBCNmRhSkdv?=
 =?utf-8?B?R1Y3elpQV1Z3YmZxekJRTmhNTVpiZWViVDl0QXU1RENOVnRIMDFXV1g0dmM0?=
 =?utf-8?B?UjFPcnc5b2xkeFhNVDY1dnFjY0dSU2hSUWpnSnhWZ1c4K0ZycFUxdW83K2pP?=
 =?utf-8?B?OGFESlFwNFpGRTN1d3BycG16TmN0TE9DM1g0Zi9pUVVSeUJQQklPTldmSEVL?=
 =?utf-8?B?Zm0zclRCWVhVdmRTNkJtWk5QTStmN25VRExyVStKTXpGUitZWVJLVGRGUVcy?=
 =?utf-8?B?dFA0cFhyY1d1Nk95QlRJVldJQTFxZHp4R010NlVTc3lHL3pPN3dPRlRrYThh?=
 =?utf-8?B?U0c2MEx2STRob3F6TXdJUEJLVWE0c0xXak0zekorZHZLK2lPYVkrTk5YNHJs?=
 =?utf-8?B?c3VHSDBKM3JzYjl5TStTTXErcFBkWVNXQW9ablFyMU5ITkZwdW1PNnBrR1Z1?=
 =?utf-8?B?cGd2WmVuY2k5NlZkQ2sySXBpV0UxQjRKVDl4WjluMnNFRllLbnhYUm9CN0xU?=
 =?utf-8?B?V2VEWTdxWnhya3VMMUJGOTkrRnZuY2V2eDZrWjdtV1ZDREswVDJ0VWdiZXUv?=
 =?utf-8?B?Vk54aUhKUWYwc1F4b2thUEVLZDl2TVJ3STFobWZZRUJBRFZFKzhPYlZpYTZE?=
 =?utf-8?B?bDBTQzJsT1JQYlZMaXVOaHZuUDIxVzBjbGc3eGVsUzhMU3gwOUZwZ1JRZUdV?=
 =?utf-8?B?ZnMwY09TY3M0WUxoUTlaaCtlUHVlRE9QcUdZTWU5QmxKaTRjS3J4TVpoZVYr?=
 =?utf-8?B?SUZHUFpLV0J6K0FVT2RQY01VdVV5SDZzVklmeWVldE9nVHJ3dElKdTR3L3hR?=
 =?utf-8?B?TVdRT3haSkVxMFdSd0owelZ3R0lHY3FMQjZHMS9XZG5Pb0NrNTQ3MnMwaUpi?=
 =?utf-8?B?dVBFeTdnZ05YN05zUTFKRkZza0xMOWxvQ2V3Qy9JWVFxYS93VVJhMTA0NFN0?=
 =?utf-8?B?QS94cWd3N2VTSVZJTzczMFpiSmd1eFBtbE1EYlBDSHFoQkNBcjF4K25Yc3Qx?=
 =?utf-8?B?SDV0TkxUTng3YTZ1a2dhYkxoZXZWbEhUTUlLTWMyQy9PL2JRaWkyYkhlOWg0?=
 =?utf-8?B?eEZreG1iLzBEcW1GaXg0UmNka20wS3dwWXA0NEU5NWgrcjBOazlOTWdyRWZQ?=
 =?utf-8?B?VGR0M2tobU1Hbk1UMWIvaXZmdDZDVnVkeFdjandTNlpyeFlJQXpvcFU0NFZX?=
 =?utf-8?B?TEVJS1dHR3RGSy9jSjZxaHZITHFvOTA0RVp1QWZwT21DSUNoVndRMUZ3VkFy?=
 =?utf-8?B?UkRJalhFbkw1TzBWcnJGVzRGb2FHNVZHVFNPZWI4RDFoWC9xVUF1cFMzM1hv?=
 =?utf-8?B?RTJ4TU85c0pFY0hhdEh6SDl2Vkh5N0kxc2JvVjIzQnd3SU95ZWxuWGpYWFJj?=
 =?utf-8?B?SkRES3FlRGxpdGNyenRrMzhBbDY4cWlnMkJjT1MwZzhDYXpVNzRMNGh4a09R?=
 =?utf-8?B?QW5JTkFucWRwOUIrbjNXSnJPWUZGL0FNbjQzNkpDWW5GeTZVOXJTdEg1dFBo?=
 =?utf-8?Q?b4noeXjkiO13YVA5UkLG15U1V5XZLEpmXjYCJPx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5117.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WkFGUHFsUVRReXdJR2F4ZElKT1ppK3NVWmFTQWFYanNuNWpaKzNjdUhSc1pp?=
 =?utf-8?B?cDdUWGlCL2VUaEVPb3dpMUU2Um1LMmpyWFA0Z0RjSjMxVnQxaW82RFZvR1RO?=
 =?utf-8?B?REpYMjNud0xoY2JudnBoa01yUUo2T044d0dRUXFGWDhUZjZlbEM2NDlFVzFq?=
 =?utf-8?B?TTlxTGsxM3hYcXVFNVdSbE41R2FuK1J6UkVWNW95UnozMXhhb2hkZEErQ1Ft?=
 =?utf-8?B?cnB3K1hzR1hoWUhWZG9uaG5JRTBnU0xjbGJoS0pBb1dmWEtwcWhheWlvdDNJ?=
 =?utf-8?B?WUJSbkpPWHNGaS9KcjRmdDdhclZVNFEwRVBBZWZGWkoxKzRPYzh6TG85UlZs?=
 =?utf-8?B?bDJnd0lSUlFpcWxJKzBjTUcrQmNoclNySFNkSGp1U1RkRHRKN2tzdi9yVGFS?=
 =?utf-8?B?MHpzTGJTbkIwOHBEU0NCZlhUaUpXSWduaS9nbWVLOGxOY1VqQzhCcHVFaHl4?=
 =?utf-8?B?NFUxR2hLbnJvT2xDRi9ZSXR0UW5WY20vZEV2WEl1ZmY5SHhjNy9lODRIM1M2?=
 =?utf-8?B?aU4vTmcvWHJoeXBsWU02NFVDRmU4M3FKMEpSUnNMVjF3MDJXK3NvSUViZHB0?=
 =?utf-8?B?YzdUN1VYdm9TdWlPQ01JYThoZEVOUVdISUxZY1AzcURDSzBEa1ZtL1Z5b2ds?=
 =?utf-8?B?MWJYaklCRzBHZGpOQzVFWldPaGZ0NXU2akR5MFF5UHR1YVhDK1RRVk5kL01G?=
 =?utf-8?B?UG85S1N2ZVlsWE5KLzBCZmpvMmZSNEN1YkVxc0tJbUx2bTRWWW9xQkZxNWJL?=
 =?utf-8?B?anorNUtWZ3B5OHpGVlhZa2RqL2M4MC9sZUdjbW1HcWpjd0R4WFAybThDYXpa?=
 =?utf-8?B?b3pSM0h1WTl3YkpkeGUyUHdIK0ZHVW45R2dFQjZzQnRkaDNsNGpGa2ZJdW5I?=
 =?utf-8?B?V3Z5U0FiaVFJNUxzQm1TWlVtRGZqdlZLRWtISklleEhDQWd1WjFmZ2Vla3A5?=
 =?utf-8?B?WkE4QlJlK1RKTTlmSUxvdy9lWkZoaHlLOVFXL1NFZkN3R1FNNGwybGVrRkIw?=
 =?utf-8?B?eEtxTEsveXRqRlZEajZsWk1nVFJsUWdvcUh1RnN5YnVaaWRTeXpvdmlVRnpV?=
 =?utf-8?B?dzVtcko3NlhCbEY1a0ZnWldJQnEyM25aejdTVDQ1eUEyMlVOdVNud3hieG5Y?=
 =?utf-8?B?MXdXMnZ0WGk1eUZjZ2xyb2JFWXp2aUJpMmhtS1lOS3d2dlJMWDk0ZHI2YytO?=
 =?utf-8?B?RTFSUWJZek85eHF1SVFTSXFaNVB2UTBKYWZKNnV5Sm9OMVg4d0xrWUxoVzBs?=
 =?utf-8?B?YU10c3NVaWVVZUQ3Z1YvRHJFMDdybHk4UWlBdHpwWklhcDB4ZGFqckE2b3N2?=
 =?utf-8?B?dlBLM08yeE10NGFjQTZ3c1dtbmt4VlRKV2tMMmxMVTMyYTBneVR0RndkSWp0?=
 =?utf-8?B?Z0gwbEQrR1NoYWcxdWMzc0p4ajNOUGRXaGZNY0Rnd1hwV1Njc3N3djRRQnBl?=
 =?utf-8?B?ZDN6Z0tiMG5WdHZWM1JFbllMdnVEejVQT3dXSVowbFZ4Q3hLUm13L050dGpX?=
 =?utf-8?B?RWF3M2JWdTJPc1lUV3prR0pOWFFCWXU2eUxiNWVrYmJJTHVXUWx6K1NMTWsz?=
 =?utf-8?B?YzhESXVrU2NPK0tQSHFwNW8yakpRcmhFNXRzeHVMV2FUMGhhVXIzSDBkd1J5?=
 =?utf-8?B?YVNFMFdGeWhCb1Jzb0xnR0Z0TEk3R0ExUlp4Z3RYREtOQTl0RUp3eW91VUFO?=
 =?utf-8?B?Y210OG9IVmkvaUZDME1sZmlYUW9Pa0N0ekY0QXFvUlNUNHpkZ1k2UjJSQjh1?=
 =?utf-8?B?VFlpTzBBeGx4UXgwR0tBOHBkNkpPWUtMZXgyS3l3Nit4eFlnbEEzaWJhMkVR?=
 =?utf-8?B?UVZ0QlpkWFFXa3BWengxbkZOelIvTS9rUlIwSk1DcVNTeXVDMmFFdUJkWUlJ?=
 =?utf-8?B?UFBqWlBVTjgraDcwdStFdks5cy8vVHROZHI4cFRvRWxkbC8yMFlVb3FvaThP?=
 =?utf-8?B?YkV5Nzc3WG9uZkY3bjZ4VEhOT2tWVm1LaWpCRkxmZm9XODNlUUNQODZKNmts?=
 =?utf-8?B?VlcrdSsvd1VnNGpTS2kyMFAvRXlYWVBPdklYNG5SWjdvVGdlZW9HZ1V6QWlp?=
 =?utf-8?B?YzVabkVQcjY3cE5jOHRlakJONDcvU0d3TGZDU2VPaHZ0RlRXKzRNWHZ4N2sw?=
 =?utf-8?B?eDZvOXQ5UjhodmtXa0h5SmZSZ3Nib05xNm5EZEpHNEFmS0k3NjNKVXloemZG?=
 =?utf-8?B?M2VSN3FLWEQ5Zngxb0xSRlBwWndTamI3RmRBUTFianBmd2xUYUtYVWl3MVAz?=
 =?utf-8?B?dGNpRnpKNWlpQ1ZRTmhKTmdsakp3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/o7Ysxx1JwQ7aW+mT8ndaP+v5nZJ60CXbGq7WzCg14+G822w/DpYVET2I27etS8jSU0gdbXJ3MrOQdM7HQoUprSPotuOJR6aCIq3GFCeHxamJZ2X+X7HWDzsFulu8Jyft2Isj7VzaE592YIfdmN3jBvGj7MsF2K5PtYDHbkdDXCIEqUIoSRICWNjGpfHZCphD2K8819CgbwzTlnHruxwPXwkCTwgdEiBFqmpuGVJMwYID5+UTCapG3vkfpIJDgIzSy1YyqZqP+wgOu5OrjfmDVAM+IzzKvlIovkLDN5juPAH36T66qJ8HTdtYJ6eIM5y0Ux5IHKxCE/coyKL2SPCmzx8dQ5x69/4hDtKm5oNXyoygIK/QNsdUZlEAqG0qSQIlN4C0TTNROh0mcW1Vb8/yEfE0JKRlhyfwAj94DhMLYTvKpNOIpO12ag6PM1l0JmdTvWiII5/WQAMzOYsk6zF3NL7wY6kSuP17QMGbw/atYuhzeqob8+DxeXnhi1FSbhNGYUkIt0GNu1wAocM9QAEOuQXTzBBM1ZDidPy7j11rvMPPJbCkLDoLf+rs9fo/N6W80zDwKorenuWlRU1ZxOhJfmjB34EROoSdyFndv0pfYo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30bf9361-5ce7-48a0-d087-08dcf52ec8c7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5117.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 19:54:06.9924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMgaUJWJ9EtzMqJq9KotiUTqbCXrpQLcYlU2fgLcLpkHQqlcYXD/TJ50aRh+7BGPVDBdIcOyuHFymuxa9GXAqTsnFv1/zqef7cg00uS7G7g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5087
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250153
X-Proofpoint-ORIG-GUID: zvZjJcqItBgZq_PKlE1LmdvtfvVZa-d9
X-Proofpoint-GUID: zvZjJcqItBgZq_PKlE1LmdvtfvVZa-d9


On 10/23/24 9:20 PM, Wei Yang wrote:
> On Wed, Aug 14, 2024 at 12:19:43PM -0400, Sidhartha Kumar wrote:
>> Users of mas_store_prealloc() enter this function with nodes already
>> preallocated. This means the store type must be already set. We can then
>> remove the call to mas_wr_store_type() and initialize the write state to
>> continue the partial walk that was done when determining the store type.
>>
> May I ask what is the partial walk here means?
>
> It is the mas_wr_walk() in mas_wr_store_type() which is stopped because of it
> is spanning write?

Yes, this is what I meant by the partial walk that's already been 
started. It's the walk done by mas_wr_store_type().

> I may lost some background, so the assumption here is mas_wr_store_type() has
> already been invoked and the store type has been decided, right?

Ya users of mas_store_prealloc() should have already called 
mas_preallocate() which does:

     mas->store_type = mas_wr_store_type(&wr_mas);
     request = mas_prealloc_calc(&wr_mas, entry);

to set the store type and allocate the nodes.


>> Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
>> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
>> ---
>> lib/maple_tree.c | 18 +++++++++++++-----
>> 1 file changed, 13 insertions(+), 5 deletions(-)
>>
>> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
>> index 8c1a1a483395..73ce63d9c3a0 100644
>> --- a/lib/maple_tree.c
>> +++ b/lib/maple_tree.c
>> @@ -3979,9 +3979,6 @@ static inline void mas_wr_end_piv(struct ma_wr_state *wr_mas)
>> 		wr_mas->end_piv = wr_mas->pivots[wr_mas->offset_end];
>> 	else
>> 		wr_mas->end_piv = wr_mas->mas->max;
>> -
>> -	if (!wr_mas->entry)
>> -		mas_wr_extend_null(wr_mas);
>> }
>>
>> static inline unsigned char mas_wr_new_end(struct ma_wr_state *wr_mas)
>> @@ -5532,8 +5529,19 @@ void mas_store_prealloc(struct ma_state *mas, void *entry)
>> {
>> 	MA_WR_STATE(wr_mas, mas, entry);
>>
>> -	mas_wr_prealloc_setup(&wr_mas);
>> -	mas_wr_store_type(&wr_mas);
>> +	if (mas->store_type == wr_store_root) {
>> +		mas_wr_prealloc_setup(&wr_mas);
>> +		goto store;
>> +	}
>> +
>> +	mas_wr_walk_descend(&wr_mas);
> This one does not descend the tree, just locate the offset in a node and
> adjust min/max. So not look like to continue the partial walk to me.
>
>> +	if (mas->store_type != wr_spanning_store) {
>> +		/* set wr_mas->content to current slot */
>> +		wr_mas.content = mas_slot_locked(mas, wr_mas.slots, mas->offset);
>> +		mas_wr_end_piv(&wr_mas);
> If not a spanning write, the previous walk should reach a leaf node, right?

Ya that's true.

> I am not sure why we don't need to check extend null here. Because we have
> already done it?


Ya we extend null in mas_wr_store_type() which has already been called 
at this point.


     /* At this point, we are at the leaf node that needs to be altered. */
     mas_wr_end_piv(wr_mas);
     if (!wr_mas->entry)
         mas_wr_extend_null(wr_mas);

Thanks,

Sid

>> +	}
>> +
>> +store:
>> 	trace_ma_write(__func__, mas, 0, entry);
>> 	mas_wr_store_entry(&wr_mas);
>> 	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
>> -- 
>> 2.46.0
>>

